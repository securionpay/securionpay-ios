import Foundation

internal struct PaymentRequest: Codable {
    let key: String
    let email: String
    let checkoutRequest: String
    let tokenId: String
    let sessionId: String
    let rememberMe: Bool
    let cvc: String?
    let verificationSmsId: String?
    let customAmount: Int?
    
    init(key: String, email: String, checkoutRequest: CheckoutRequest, tokenID: String, sessionID: String, rememberMe: Bool, cvc: String? = nil, sms: SMS?, customAmount: Int?) {
        self.key = key
        self.email = email
        self.checkoutRequest = checkoutRequest.content
        self.tokenId = tokenID
        self.sessionId = sessionID
        self.rememberMe = rememberMe
        self.cvc = cvc
        self.verificationSmsId = sms?.id
        self.customAmount = customAmount
    }
}
