import Foundation

@objc(SPCustomer)
public class Customer: NSObject, Codable {
    @objc public let id: String
}

@objc(SPPaymentResult)
public class PaymentResult: NSObject, Codable {
    @objc public let customer: Customer?
    @objc public let chargeId: String?
    @objc public let subscriptionId: String?
}
