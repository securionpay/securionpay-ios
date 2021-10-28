import Foundation

struct ThreeDSecureAuthentication: Codable {
    class Ares: NSObject, Codable {
        enum TransactionStatus: String, Codable {
            case correct = "Y"
            case incorrect = "N"
            case challenge = "C"
            case dChallenge = "D"
        }
        let messageVersion: String
        let clientAuthResponse: String
        let transStatus: TransactionStatus
    }
    
    let ares: Ares
}
