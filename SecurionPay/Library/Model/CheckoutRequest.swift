import Foundation

internal struct Subscription: Equatable {
    internal let planId: String
}

internal struct CompleteSubscription: Codable {
    internal struct Plan: Codable {
        internal let amount: Int
        internal let currency: String
    }

    internal var readable: String {
        CurrencyFormatter.format(amount: plan.amount, code: plan.currency)
    }
    
    internal let plan: Plan
}

internal struct Donation: Equatable {
    internal let amount: Int
    internal let currency: String
    
    internal var readable: String {
        CurrencyFormatter.format(amount: amount, code: currency)
    }
}

@objc(SPCheckoutRequest)
public class CheckoutRequest: NSObject {
    @objc public init(content: String) {
        self.content = content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    internal let content: String
}

extension CheckoutRequest {
    internal var amount: Int {
        guard let charge = jsonDict["charge"] as? [String: Any] else { return 0 }
        guard let amount = charge["amount"] as? Int else { return 0 }
        return amount
    }
    
    internal var currency: String {
        guard let charge = jsonDict["charge"] as? [String: Any] ?? jsonDict["customCharge"] as? [String: Any] else { return "" }
        guard let currency = charge["currency"] as? String else { return "" }
        return currency
    }
    
    internal var threeDSecure: Bool {
        guard let threeDSecure = jsonDict["threeDSecure"] as? [String: Any] else { return false }
        guard let enable = threeDSecure["enable"] as? Bool else { return false }
        return enable
    }
    
    internal var requireEnrolledCard: Bool {
        guard let threeDSecure = jsonDict["threeDSecure"] as? [String: Any] else { return true }
        guard let enable = threeDSecure["requireEnrolledCard"] as? Bool else { return true }
        return enable
    }
    
    internal var requireSuccessfulLiabilityShiftForEnrolledCard: Bool {
        guard let threeDSecure = jsonDict["threeDSecure"] as? [String: Any] else { return true }
        guard let enable = threeDSecure["requireSuccessfulLiabilityShiftForEnrolledCard"] as? Bool else { return true }
        return enable
    }
    
    internal var readable: String {
        CurrencyFormatter.format(amount: amount, code: currency)
    }
    
    internal var rememberMe: Bool {
        jsonDict["rememberMe"] as? Bool ?? false
    }
    
    internal var termsAndConditions: String? {
        jsonDict["termsAndConditionsUrl"] as? String
    }
    
    internal var customerId: String? {
        jsonDict["customerId"] as? String
    }
    
    internal var crossSaleOfferIds: [String]? {
        jsonDict["crossSaleOfferIds"] as? [String]
    }
    
    internal var correct: Bool {
        return !jsonDict.isEmpty
    }
    
    internal var donations: [Donation]? {
        guard let customCharge = jsonDict["customCharge"] as? [String: Any] else { return nil }
        guard let amountOptions = customCharge["amountOptions"] as? [Int] else { return nil }
        guard let currency = customCharge["currency"] as? String else { return nil }
        
        let result = amountOptions.map { Donation(amount: $0, currency: currency) }
        return result.isEmpty ? nil : result
    }
    
    internal var customDonation: (Int, Int)? {
        guard let customCharge = jsonDict["customCharge"] as? [String: Any] else { return nil }
        guard let customAmount = customCharge["customAmount"] as? [String: Int] else { return nil }
        guard let min = customAmount["min"], let max = customAmount["max"] else { return nil }
        
        return (min, max)
    }
    
    internal var subscription: Subscription? {
        guard let subscription = jsonDict["subscription"] as? [String: Any] else { return nil }
        guard let planId = subscription["planId"] as? String else { return nil }
        return Subscription(planId: planId)
    }
    
    private var jsonDict: [String: Any] {
        guard let decodedData = Data(base64Encoded: self.content) else { return [:] }
        let decoded = String(data: decodedData, encoding: .utf8)
        guard let json = decoded?.components(separatedBy: "|").last else { return [:] }
        return ((try? JSONSerialization.jsonObject(with: json.data(using: .utf8) ?? Data(), options: [])) as? [String: Any]) ?? [:]
    }
}
