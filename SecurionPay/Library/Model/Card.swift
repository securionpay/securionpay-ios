import Foundation

@objc(SPCardExpiration)
public class CardExpiration: NSObject, Codable {
    @objc public let month: String
    @objc public let year: String
}

@objc(SPCard)
public class Card: NSObject, Codable {
    @objc public let last2: String?
    @objc public let last4: String?
    @objc public let brand: String
    @objc public let expiration: CardExpiration?
}
