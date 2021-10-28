import Foundation

@objc(SPLiabilityShift)
public enum LiabilityShift: Int {
    case failed
    case notPossible
    case successful
    case none
}

@objc(SPThreeDSecureInfo)
public class ThreeDSecureInfo: NSObject, Codable {
    enum CodingKeys: String, CodingKey {
        case amount
        case currency
        case enrolled
        case version
        case liabilityShiftRaw = "liabilityShift"
    }
    private enum LiabilityShiftRaw: String, Codable {
        case failed = "failed"
        case notPossible = "not_possible"
        case successful = "successful"
    }
    @objc public let amount: Int
    @objc public let currency: String
    @objc public let enrolled: Bool
    @objc public let version: String
    @objc public var liabilityShift: LiabilityShift {
        guard let liabilityShiftRaw = liabilityShiftRaw else { return .none }
        switch (liabilityShiftRaw) {
        case .failed: return .failed
        case .notPossible: return .notPossible
        case .successful: return .successful
        }
    }
    private let liabilityShiftRaw: LiabilityShiftRaw?
}
