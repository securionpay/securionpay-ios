import Foundation
import UIKit

@objc(SecurionPay)
public final class SecurionPay: NSObject {
    @objc public static let shared = SecurionPay()
    @objc public var publicKey: String?
    
    private let apiProvider = APIProvider()
    private let authenticator = ThreeDAuthenticator()
    
    private override init() {
        FontsLoader.loadFontsIfNeeded()
    }
    
    @objc public func showCheckoutViewController(
        in viewController: UIViewController,
        checkoutRequest: CheckoutRequest,
        completion: @escaping (PaymentResult?, SecurionPayError?) -> Void) {
            checkIsConfigured()
            
            if !checkoutRequest.correct { completion(nil, .incorrectCheckoutRequest); return }
            if checkoutRequest.termsAndConditions != nil { completion(nil, .unsupportedValue(value: "termsAndConditionsUrl")); return }
            if checkoutRequest.customerId != nil { completion(nil, .unsupportedValue(value: "customerId")); return }
            if checkoutRequest.crossSaleOfferIds != nil { completion(nil, .unsupportedValue(value: "crossSaleOfferIds")); return }
            
            let paymentViewController = UINavigationController(rootViewController: CheckoutViewController(checkoutRequest: checkoutRequest, completion: completion))
            paymentViewController.modalPresentationStyle = .overFullScreen
            viewController.present(paymentViewController, animated: true, completion: nil)
        }
    
    @objc public func cleanSavedCards() {
        checkIsConfigured()
        Keychain.cleanSavedEmails()
    }
    
    @objc public func createToken(
        with request: TokenRequest,
        completion: @escaping (Token?, SecurionPayError?) -> Void) {
            checkIsConfigured()
            
            apiProvider.createToken(with: request, completion: completion)
        }
    
    @objc public func authenticate(
        token: Token,
        amount: Int,
        currency: String,
        navigationControllerFor3DS: UINavigationController,
        completion: @escaping (Token?, SecurionPayError?) -> Void) {
            checkIsConfigured()
            
            authenticator.authenticate(token: token, amount: amount, currency: currency, navigationControllerFor3DS: navigationControllerFor3DS, completion: completion)
        }
    
    private func checkIsConfigured() {
        if (publicKey ?? "").isEmpty {
            fatalError("You must set SecurionPay.shared.publicKey before using SDK.")
        }
    }
}
