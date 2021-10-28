import Foundation
import CryptoKit
final class CheckoutRequestGenerator {
    func generate(
        amount: Int = 10000,
        currency: String = "EUR",
        rememberMe: Bool = false,
        threeDS: Bool? = nil,
        termsAndConditionsUrl: String? = nil,
        customerId: String? = nil,
        crossSaleOfferIds: [String]? = nil
    ) -> String {
        let threeDSecureData: CheckoutRequestData.ThreeDSecure?
        if let threeDS = threeDS {
            threeDSecureData = CheckoutRequestData.ThreeDSecure(
                enable: threeDS,
                requireEnrolledCard: threeDS,
                requireSuccessfulLiabilityShiftForEnrolledCard: threeDS
            )
        } else {
            threeDSecureData = nil
        }
        
        let request = CheckoutRequestData(
            charge: CheckoutRequestData.Charge(amount: amount, currency: currency),
            subscription: nil,
            customCharge: nil,
            threeDSecure: threeDSecureData,
            rememberMe: rememberMe,
            customerId: customerId,
            crossSaleOfferIds: crossSaleOfferIds,
            termsAndConditionsUrl: termsAndConditionsUrl
        )
        
        return encodeRequest(data: request)
    }
    
    func generateDonation(options: [Int]? = [1000, 2000, 3000], min: Int? = nil, max: Int? = nil, currency: String = "EUR", rememberMe: Bool = false, threeDS: Bool? = nil) -> String {
        let custom: CheckoutRequestData.Donation.CustomAmount?
        if let min = min, let max = max {
            custom = CheckoutRequestData.Donation.CustomAmount(min: min, max: max)
        } else {
            custom = nil
        }
        let threeDSecureData: CheckoutRequestData.ThreeDSecure?
        if let threeDS = threeDS {
            threeDSecureData = CheckoutRequestData.ThreeDSecure(
                enable: threeDS,
                requireEnrolledCard: threeDS,
                requireSuccessfulLiabilityShiftForEnrolledCard: threeDS
            )
        } else {
            threeDSecureData = nil
        }
        
        let request = CheckoutRequestData(
            charge: nil,
            subscription: nil,
            customCharge: CheckoutRequestData.Donation(amountOptions: options, customAmount: custom, currency: currency),
            threeDSecure: threeDSecureData,
            rememberMe: rememberMe,
            customerId: nil,
            crossSaleOfferIds: nil,
            termsAndConditionsUrl: nil
        )
        
        return encodeRequest(data: request)
    }
    
    func generateSubscription(planId: String, threeDS: Bool? = nil) -> String {
        let threeDSecureData: CheckoutRequestData.ThreeDSecure?
        if let threeDS = threeDS {
            threeDSecureData = CheckoutRequestData.ThreeDSecure(
                enable: threeDS,
                requireEnrolledCard: threeDS,
                requireSuccessfulLiabilityShiftForEnrolledCard: threeDS
            )
        } else {
            threeDSecureData = nil
        }
        let request = CheckoutRequestData(
            charge: nil,
            subscription: CheckoutRequestData.Subscription(planId: planId),
            customCharge: nil,
            threeDSecure: threeDSecureData,
            rememberMe: nil,
            customerId: nil,
            crossSaleOfferIds: nil,
            termsAndConditionsUrl: nil
        )
        
        return encodeRequest(data: request)
    }
    
    private func encodeRequest(data: CheckoutRequestData) -> String {
        let jsonData = try! JSONEncoder().encode(data)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        let key = SymmetricKey(data: SecurionPayAPI.secretKey.data(using: .utf8)!)
        let signature = HMAC<SHA256>.authenticationCode(for: jsonString.data(using: .utf8)!, using: key)
        let signed = Data(signature).map { String(format: "%02hhx", $0) }.joined()
        
        return Data((signed + "|" + jsonString).utf8).base64EncodedString()
    }

    private struct CheckoutRequestData: Codable {
        struct Charge: Codable {
            let amount: Int
            let currency: String
        }
        struct Subscription: Codable {
            let planId: String
        }
        struct ThreeDSecure: Codable {
            let enable: Bool
            let requireEnrolledCard: Bool
            let requireSuccessfulLiabilityShiftForEnrolledCard: Bool
        }
        struct Donation: Codable {
            struct CustomAmount: Codable {
                let min: Int
                let max: Int
            }
            let amountOptions: [Int]?
            let customAmount: CustomAmount?
            let currency: String
        }
        
        let charge: Charge?
        let subscription: Subscription?
        let customCharge: Donation?
        let threeDSecure: ThreeDSecure?
        let rememberMe: Bool?
        let customerId: String?
        let crossSaleOfferIds: [String]?
        let termsAndConditionsUrl: String?
    }
}
