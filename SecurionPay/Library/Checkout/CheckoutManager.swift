import Foundation
import UIKit

internal final class CheckoutManager {
    private let apiProvider = APIProvider()
    
    internal func pay(
        token: Token,
        checkoutRequest: CheckoutRequest,
        email: String,
        remember: Bool = false,
        cvc: String? = nil,
        sms: SMS? = nil,
        amount: Int? = nil,
        currency: String? = nil,
        navigationControllerFor3DS: UIViewController,
        completion: @escaping (PaymentResult?, SecurionPayError?) -> Void) {
            apiProvider.checkoutRequestDetails(checkoutRequest: checkoutRequest) { [weak self] details, detailsError in
                guard let self = self else { return }
                guard let details = details else { completion(nil, detailsError); return }
                guard details.threeDSecureRequired else {
                    self.apiProvider.pay(
                        token: token,
                        checkoutRequest: checkoutRequest,
                        sessionId: details.sessionId,
                        email: email,
                        remember: remember,
                        cvc: cvc,
                        sms: sms,
                        amount: checkoutRequest.subscription != nil ? nil : amount,
                        completion: completion)
                    return
                }
                
                self.apiProvider.threeDSecureCheck(token: token, amount: amount ?? checkoutRequest.amount, currency: currency ?? checkoutRequest.currency) { [weak self] initResponse, initializationError in
                    guard let self = self else { return }
                    guard let initResponse = initResponse else { completion(nil, initializationError); return }
                    let enrolled = initResponse.token.threeDSecureInfo?.enrolled ?? false
                    
                    if checkoutRequest.requireEnrolledCard && !enrolled {
                        completion(nil, .enrolledCardIsRequired)
                        return
                    }
                    
                    guard enrolled && initResponse.version.hasPrefix("2") else {
                        self.apiProvider.pay(
                            token: token,
                            checkoutRequest: checkoutRequest,
                            sessionId: details.sessionId,
                            email: email,
                            remember: remember,
                            cvc: cvc,
                            sms: sms,
                            amount: checkoutRequest.subscription != nil ? nil : amount,
                            completion: completion)
                        return
                    }
                    
                    do {
                        let threeDSecureWarnings = try ThreeDManager.shared.initializeSDK(
                            cardBrand: initResponse.token.brand,
                            certificate: initResponse.directoryServerCertificate,
                            sdkLicense: initResponse.sdkLicense ?? .empty,
                            bundleIdentifier: SecurionPay.shared.bundleIdentifier ?? .empty
                        )
                        try ThreeDManager.shared.createTransaction(
                            version: initResponse.version,
                            cardBrand: initResponse.token.brand
                        )
                        guard let authRequestParam = try ThreeDManager.shared.getAuthenticationRequestParameters()?.getAuthRequest(), !authRequestParam.isEmpty else {
                            if let warning = threeDSecureWarnings.first {
                                completion(nil, .threeDError(with: warning))
                            } else {
                                completion(nil, .unknown3DSecureError)
                            }
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
                            case .correct, .attemptPerformed, .unknown:
                                self.apiProvider.threeDSecureComplete(token: initResponse.token) { securedToken, _ in
                                    self.apiProvider.pay(
                                        token: securedToken ?? initResponse.token,
                                        checkoutRequest: checkoutRequest,
                                        sessionId: details.sessionId,
                                        email: email,
                                        remember: remember,
                                        cvc: cvc,
                                        sms: sms,
                                        amount: checkoutRequest.subscription != nil ? nil : amount
                                    ) { paymentResult, paymentError in
                                        ThreeDManager.shared.cancelProgressDialog()
                                        completion(paymentResult, paymentError)
                                    }
                                }
                            case .incorrect, .technicalProblem, .rejected:
                                if checkoutRequest.requireSuccessfulLiabilityShiftForEnrolledCard {
                                    ThreeDManager.shared.cancelProgressDialog();
                                    completion(nil, .successfulLiabilityShiftIsRequired);
                                    return
                                } else {
                                    self.apiProvider.threeDSecureComplete(token: initResponse.token) { securedToken, _ in
                                        self.apiProvider.pay(
                                            token: securedToken ?? initResponse.token,
                                            checkoutRequest: checkoutRequest,
                                            sessionId: details.sessionId,
                                            email: email,
                                            remember: remember,
                                            cvc: cvc,
                                            sms: sms,
                                            amount: checkoutRequest.subscription != nil ? nil : amount
                                        ) { paymentResult, paymentError in
                                            ThreeDManager.shared.cancelProgressDialog()
                                            completion(paymentResult, paymentError)
                                        }
                                    }
                                }
                            case .challenge, .dChallenge:
                                let resp = authenticationResult?.ares.clientAuthResponse.fromBase64() ?? .empty
                                do {
                                    try ThreeDManager.shared.startChallenge(resp, navigationControllerFor3DS) { [weak self] success, error in
                                        ThreeDManager.shared.cancelProgressDialog()
                                        
                                        if let error = error {
                                            completion(nil, error)
                                        }
                                        if !success { completion(nil, nil); return }
                                        guard let self = self else { return }
                                        self.apiProvider.threeDSecureComplete(token: initResponse.token) { securedToken, _ in
                                            if let securedToken = securedToken,
                                                securedToken.threeDSecureInfo?.liabilityShift == .failed,
                                                checkoutRequest.requireSuccessfulLiabilityShiftForEnrolledCard {
                                                    completion(nil, .successfulLiabilityShiftIsRequired)
                                            } else {
                                                self.apiProvider.pay(
                                                    token: securedToken ?? initResponse.token,
                                                    checkoutRequest: checkoutRequest,
                                                    sessionId: details.sessionId,
                                                    email: email,
                                                    remember: remember,
                                                    cvc: cvc,
                                                    sms: sms,
                                                    amount: checkoutRequest.subscription != nil ? nil : amount
                                                ) { paymentResult, paymentError in
                                                    completion(paymentResult, paymentError)
                                                }
                                            }
                                        }
                                    }
                                } catch {
                                    ThreeDManager.shared.cancelProgressDialog()
                                    completion(nil, .unknown3DSecureError)
                                }
                            }
                        }
                    }
                    catch {
                        completion(nil, .unknown3DSecureError)
                    }
                }
            }
        }
    
    internal func pay(
        tokenRequest: TokenRequest,
        checkoutRequest: CheckoutRequest,
        email: String,
        remember: Bool = false,
        cvc: String? = nil,
        sms: SMS? = nil,
        amount: Int? = nil,
        currency: String? = nil,
        navigationControllerFor3DS: UIViewController,
        completion: @escaping (PaymentResult?, SecurionPayError?) -> Void) {
            apiProvider.createToken(with: tokenRequest) { [weak self] token, error in
                guard let self = self else { return }
                if let token = token {
                    self.pay(token: token, checkoutRequest: checkoutRequest, email: email, remember: remember, cvc: cvc, sms: sms, amount: amount, currency: currency, navigationControllerFor3DS: navigationControllerFor3DS, completion: completion)
                } else {
                    completion(nil, error)
                }
            }
        }
    
    internal func checkoutRequestDetails(
        checkoutRequest: CheckoutRequest,
        completion: @escaping(CheckoutRequestDetails?, SecurionPayError?) -> Void) {
            apiProvider.checkoutRequestDetails(checkoutRequest: checkoutRequest, completion: completion)
        }
    
    internal func lookup(
        email: String,
        completion: @escaping (LookupResult?, SecurionPayError?) -> Void) {
            apiProvider.lookup(email: email, completion: completion)
        }
    
    internal func savedToken(
        email: String,
        completion: @escaping (Token?, SecurionPayError?) -> Void) {
            apiProvider.savedToken(email: email, completion: completion)
        }
    
    internal func sendSMS(
        email: String,
        completion: @escaping (SMS?, SecurionPayError?) -> Void) {
            apiProvider.sendSMS(email: email, completion: completion)
        }
    
    internal func verifySMS(
        code: String,
        sms: SMS,
        completion: @escaping (VerifySMSResponse?, SecurionPayError?) -> Void) {
            apiProvider.verifySMS(code: code, sms: sms, completion: completion)
        }
}
