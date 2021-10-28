import Foundation

@objc(SPError)
public class SecurionPayError: NSObject, Codable {
    public enum ErrorType: String, Codable {
        case invalidRequest = "invalid_request"
        case cardError = "card_error"
        case gatewayError = "gateway_error"
        case invalidVerificationCode = "invalid-verification-code"
        
        case unknown
        case unsupportedValue
        case incorrectCheckoutRequest
        
        public init(from decoder: Decoder) throws {
            self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }
    }
    
    public enum ErrorCode: String, Codable {
        case invalidNumber = "invalid_number"
        case invalidExpiryMonth = "invalid_expiry_month"
        case invalidExpiryYear = "invalid_expiry_year"
        case invalidCVC = "invalid_cvc"
        case incorrectCVC = "incorrect_cvc"
        case incorrectZip = "incorrect_zip"
        case expiredCard = "expired_card"
        case insufficientFunds = "insufficient_funds"
        case lostOrStolen = "lost_or_stolen"
        case suspectedFraud = "suspected_fraud"
        case cardDeclined = "card_declined"
        case processingError = "processing_error"
        case blacklisted = "blacklisted"
        case expiredToken = "expired_token"
        case limitExcedeed = "limit_exceeded"
        case invalidVerificationCode = "invalid-verification-code"
        case verificationCodeRequired = "verification-code-required"
        case enrolledCardIsRequired = "enrolledCardIsRequired"
        case successfulLiabilityShiftIsRequired = "successfulLiabilityShiftIsRequired"
        case authenticationRequired = "authentication_required"
        case invalidEmail = "invalid_email"
        
        case unknown
        
        public init(from decoder: Decoder) throws {
            self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }
    }
    
    let type: ErrorType
    let code: ErrorCode?
    let message: String
    
    init(type: ErrorType, code: ErrorCode?, message: String) {
        if type == .invalidRequest, message.hasPrefix("email: ") {
            self.type = type
            self.code = .invalidEmail
            self.message = message.replacingOccurrences(of: "email: ", with: "")
        } else {
            self.type = type
            self.code = code
            self.message = message
        }
    }
    
    init(error: Error) {
        type = .unknown
        code = nil
        message = error.localizedDescription
    }
    
    static var unknown: SecurionPayError {
        SecurionPayError(type: .unknown, code: nil, message: String.localized("unknown_error"))
    }
    
    static func unsupportedValue(value: String) -> SecurionPayError {
        SecurionPayError(type: .unsupportedValue, code: nil, message: "Unsupported value: \(value)")
    }
    
    static var incorrectCheckoutRequest: SecurionPayError {
        SecurionPayError(type: .incorrectCheckoutRequest, code: nil, message: "Incorrect checkout request")
    }
    
    static var enrolledCardIsRequired: SecurionPayError {
        SecurionPayError(type: .invalidRequest, code: .enrolledCardIsRequired, message: "The charge requires cardholder authentication.")
    }
    
    static var successfulLiabilityShiftIsRequired: SecurionPayError {
        SecurionPayError(type: .invalidRequest, code: .successfulLiabilityShiftIsRequired, message: "The charge requires cardholder authentication.")
    }
    
    @objc public func localizedMessage() -> String {
        let notFoundToken = "_NOT_FOUND_"
        let key = (code ?? .unknown).rawValue.components(separatedBy: ".").last ?? ""
        let result = String.localized(key, value: notFoundToken)
        if result == notFoundToken {
            return message.isEmpty ? SecurionPayError.unknown.message : message
        } else {
            return result
        }
    }
}
