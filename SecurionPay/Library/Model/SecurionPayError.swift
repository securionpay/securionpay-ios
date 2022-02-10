import Foundation
import ipworks3ds_sdk

@objc(SPError)
public final class SecurionPayError: NSObject, Codable {
    public enum ErrorType: String, Codable {
        case invalidRequest = "invalid_request"
        case cardError = "card_error"
        case gatewayError = "gateway_error"
        case invalidVerificationCode = "invalid-verification-code"
        
        case unknown
        case sdk
        case threeDSecure
        
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
        case invalidVerificationCode = "verification_code_invalid"
        case verificationCodeRequired = "verification_code_required"
        case enrolledCardIsRequired = "enrolledCardIsRequired"
        case successfulLiabilityShiftIsRequired = "successfulLiabilityShiftIsRequired"
        case authenticationRequired = "authentication_required"
        case invalidEmail = "invalid_email"
        case unsupportedValue
        case incorrectCheckoutRequest
        case deviceJailbroken
        case integrityTampered
        case simulator
        case osNotSupported
        
        case anotherOperation
        
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
    
    internal init(error: Error) {
        type = .unknown
        code = nil
        message = error.localizedDescription
    }
    
    static internal var unknown: SecurionPayError {
        SecurionPayError(type: .unknown, code: nil, message: .localized("unknown_error"))
    }
    
    static internal var unknown3DSecureError: SecurionPayError {
        SecurionPayError(type: .threeDSecure, code: .unknown, message: "Unknown 3D Secure Error. Check your SDK integration.")
    }
    
    static internal func unsupportedValue(value: String) -> SecurionPayError {
        SecurionPayError(type: .sdk, code: .unsupportedValue, message: "Unsupported value: \(value)")
    }
    
    static internal var incorrectCheckoutRequest: SecurionPayError {
        SecurionPayError(type: .sdk, code: .incorrectCheckoutRequest, message: "Incorrect checkout request")
    }
    
    static internal var enrolledCardIsRequired: SecurionPayError {
        SecurionPayError(type: .invalidRequest, code: .enrolledCardIsRequired, message: "The charge requires cardholder authentication.")
    }
    
    static internal var successfulLiabilityShiftIsRequired: SecurionPayError {
        SecurionPayError(type: .invalidRequest, code: .successfulLiabilityShiftIsRequired, message: "The charge requires cardholder authentication.")
    }
    
    static internal func threeDError(with warning: Warning) -> SecurionPayError {
        switch (warning.getID()) {
        case "SW01": return SecurionPayError(type:.threeDSecure, code: .deviceJailbroken, message: warning.getMessage())
        case "SW02": return SecurionPayError(type:.threeDSecure, code: .integrityTampered, message: warning.getMessage())
        case "SW03": return SecurionPayError(type:.threeDSecure, code: .simulator, message: warning.getMessage())
        case "SW05": return SecurionPayError(type:.threeDSecure, code: .osNotSupported, message: warning.getMessage())
        default: return SecurionPayError(type:.threeDSecure, code: .unknown, message: warning.getMessage())
        }
    }
    
    static internal var busy: SecurionPayError {
        SecurionPayError(type: .sdk, code: .anotherOperation, message: "Another task is in progress.")
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
