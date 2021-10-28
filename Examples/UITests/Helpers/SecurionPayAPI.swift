import Foundation
import XCTest

struct Charge: Codable {
    struct Card: Codable {
        let id: String
        let first6: String
        let last4: String
        let expMonth: String
        let expYear: String
    }
    let id: String
    let amount: Int
    let currency: String
    let card: Card
    let captured: Bool
    let refunded: Bool
    let customerId: String
    let subscriptionId: String?
}

struct Plan: Codable {
    let id: String
    let amount: Int
    let currency: String
}

struct Subscription: Codable {

}

struct ThreeDSecureInfo: Codable {
    public let enrolled: Bool
    public let version: String
    public let liabilityShift: String
    let amount: Int
    let currency: String
}


struct Token: Codable {
    public enum CodingKeys: String, CodingKey {
        case id
        case created
        case objectType
        case first6
        case last4
        case fingerprint
        case expirationMonth = "expMonth"
        case expirationYear = "expYear"
        case cardholder = "cardholderName"
        case brand
        case type
        case country
        case used
        case threeDSecureInfo
    }
    
    public let id: String
    public let created: Int?
    public let objectType: String?
    public let first6: String?
    public let last4: String?
    public let fingerprint: String?
    public let expirationMonth: String?
    public let expirationYear: String?
    public let cardholder: String?
    public let brand: String
    public let type: String?
    public let country: String?
    public let used: Bool?
    
    public let threeDSecureInfo: ThreeDSecureInfo?
}

final class SecurionPayAPI {
    public static let shared = SecurionPayAPI()
    private let session: URLSession = URLSession(configuration: .default)
    @objc public static let publicKey = "pk_test_5Es53HxsxAlE4Cy43dzs3ZR4"
    @objc public static let secretKey = "sk_test_1eOlRNH8cNc1iYh6YFYTbkkg"
    
    private var semaphore = DispatchSemaphore(value: 0)
    
    public func getCharge(with id: String) -> Charge {
        guard let url = URL(string: APIConfig.apiURL) else { fatalError() }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("charges/\(id)"))
        urlRequest.httpMethod = "GET"
        
        do {
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Basic \(Data((SecurionPayAPI.secretKey + ":").utf8).base64EncodedString())", forHTTPHeaderField: "Authorization")
        }
        
        var result: Charge?
        semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let decodedToken = try? decoder.decode(Charge.self, from: data) {
                    result = decodedToken
                    self.semaphore.signal()
                }
            } else {
                XCTFail()
            }
        })
        
        task.resume()
        semaphore.wait()
        return result!
    }
    
    public func getSubscription(with id: String) -> Subscription {
        guard let url = URL(string: APIConfig.apiURL) else { fatalError() }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("subscriptions/\(id)"))
        urlRequest.httpMethod = "GET"
        
        do {
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Basic \(Data((SecurionPayAPI.secretKey + ":").utf8).base64EncodedString())", forHTTPHeaderField: "Authorization")
        }
        
        var result: Subscription?
        semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let decodedToken = try? decoder.decode(Subscription.self, from: data) {
                    result = decodedToken
                    self.semaphore.signal()
                }
            } else {
                XCTFail()
            }
        })
        
        task.resume()
        semaphore.wait()
        return result!
    }
    
    public func getToken(with id: String) -> Token {
        guard let url = URL(string: APIConfig.apiURL) else { fatalError() }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("tokens/\(id)"))
        urlRequest.httpMethod = "GET"
        
        do {
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Basic \(Data((SecurionPayAPI.secretKey + ":").utf8).base64EncodedString())", forHTTPHeaderField: "Authorization")
        }
        
        var result: Token?
        semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let decodedToken = try? decoder.decode(Token.self, from: data) {
                    result = decodedToken
                    self.semaphore.signal()
                }
            } else {
                XCTFail()
            }
        })
        
        task.resume()
        semaphore.wait()
        return result!
    }
    
    public func createPlan(amount: Int, currency: String) -> Plan {
        guard let url = URL(string: APIConfig.apiURL) else { fatalError() }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("plans"))
        urlRequest.httpMethod = "POST"
        
        struct PlanRequest: Codable {
            let amount: Int
            let currency: String
            let interval: String
            let name: String
        }
        
        let request = PlanRequest(amount: amount, currency: currency, interval: "year", name: "plan \(amount) \(currency)")
        
        do {
            let encoder = JSONEncoder()
            let data = try! encoder.encode(request)
            urlRequest.httpBody = data
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Basic \(Data((SecurionPayAPI.secretKey + ":").utf8).base64EncodedString())", forHTTPHeaderField: "Authorization")
        }
        
        var result: Plan?
        semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let decodedToken = try? decoder.decode(Plan.self, from: data) {
                    result = decodedToken
                    self.semaphore.signal()
                }
            } else {
                XCTFail()
            }
        })
        
        task.resume()
        semaphore.wait()
        return result!
    }
}

