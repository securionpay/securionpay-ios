import Foundation
import UIKit

internal class ThreeDAuthenticator {
    private let apiProvider = APIProvider()
    
    @objc public func authenticate(
        token: Token,
        amount: Int,
        currency: String,
        navigationControllerFor3DS: UINavigationController,
        completion: @escaping (Token?, SecurionPayError?) -> Void) {
            self.apiProvider.threeDSecureCheck(token: token, amount: amount, currency: currency) { [weak self] initResponse, initializationError in
                guard let self = self else { return }
                guard let initResponse = initResponse else { completion(nil, initializationError); return }
                
                guard initResponse.token.threeDSecureInfo?.enrolled ?? false && initResponse.version.hasPrefix("2") else {
                    completion(initResponse.token, nil)
                    return
                }
                
                do {
                    try ThreeDManager.shared.initializeSDK(
                        cardBrand: initResponse.token.brand,
                        certificate: initResponse.directoryServerCertificate,
                        sdkLicense: initResponse.sdkLicense ?? ""
                    )
                    try ThreeDManager.shared.createTransaction(version: initResponse.version, cardBrand: initResponse.token.brand)
                    guard let authRequestParam = try ThreeDManager.shared.getAuthenticationRequestParameters()?.getAuthRequest() else {
                        completion(nil, .unknown)
                        return
                    }
                    try ThreeDManager.shared.showProgressDialog()
                    
                    self.apiProvider.threeDSecureAuthenticate(token: initResponse.token, authenticationParameters: authRequestParam) { [weak self] authenticationResult, authenticationError in
                        guard let self = self else { return }
                        guard let result = authenticationResult else {
                            ThreeDManager.shared.cancelProgressDialog();
                            completion(nil, authenticationError);
                            return
                        }
                        
                        switch (result.ares.transStatus) {
                        case .correct, .incorrect:
                            self.apiProvider.threeDSecureComplete(token: initResponse.token) { securedToken, _ in
                                ThreeDManager.shared.cancelProgressDialog();
                                completion(securedToken, nil)
                            }
                            
                        case .challenge, .dChallenge:
                            let resp = authenticationResult?.ares.clientAuthResponse.fromBase64() ?? .empty
                            do {
                                try ThreeDManager.shared.startChallenge(resp, navigationControllerFor3DS) { [weak self] success, error in
                                    if let error = error {
                                        ThreeDManager.shared.cancelProgressDialog()
                                        completion(nil, error)
                                    }
                                    if !success { completion(nil, nil); return }
                                    guard let self = self else { return }
                                    self.apiProvider.threeDSecureComplete(token: initResponse.token) { securedToken, _ in
                                        ThreeDManager.shared.cancelProgressDialog()
                                        completion(securedToken, nil)
                                    }
                                }
                            } catch {
                                ThreeDManager.shared.cancelProgressDialog()
                                completion(nil, .unknown)
                            }
                        }
                    }
                }
                catch {
                    completion(nil, .unknown)
                }
            }
        }
}
