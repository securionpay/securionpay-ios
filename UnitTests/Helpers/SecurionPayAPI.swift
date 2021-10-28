import Foundation
import XCTest
@testable import SecurionPay

struct Plan: Codable {
    let id: String
    let amount: Int
    let currency: String
}

struct Subscription: Codable {
    let id: String
    let planId: String
    let customerId: String
}

struct ThreeDSecureInfo: Codable {
    let amount: Int
    let currency: String
    let enrolled: Bool
    let version: String
    let liabilityShift: String
}

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
    let threeDSecureInfo: ThreeDSecureInfo?
}

@objc class SecurionPayAPI: NSObject {
    public static let shared = SecurionPayAPI()
    private let session: URLSession = URLSession(configuration: .default)
    @objc public static let publicKey = "pk_test_5Es53HxsxAlE4Cy43dzs3ZR4"
    @objc public static let secretKey = "sk_test_1eOlRNH8cNc1iYh6YFYTbkkg"
    
    private var semaphore = DispatchSemaphore(value: 0)
    
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
    
    public func createToken(number: String) -> Token {
        createToken(request: TokenRequest(number: number, expirationMonth: "12", expirationYear: "2030", cvc: "123"))
    }
    
    public func createToken(request: TokenRequest = TokenRequest(number: "4242424242424242", expirationMonth: "10", expirationYear: "2030", cvc: "123")) -> Token {
        guard let url = URL(string: APIConfig.apiURL) else { fatalError() }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("tokens"))
        urlRequest.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            let data = try! encoder.encode(request)
            urlRequest.httpBody = data
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Basic \(Data((SecurionPayAPI.publicKey + ":").utf8).base64EncodedString())", forHTTPHeaderField: "Authorization")
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
    
    public func getPlan(with id: String) -> Plan {
        guard let url = URL(string: APIConfig.apiURL) else { fatalError() }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("plans/\(id)"))
        urlRequest.httpMethod = "GET"
        
        do {
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
    
    public func getSubscription(with id: String, customerId: String) -> Subscription {
        guard let url = URL(string: APIConfig.apiURL) else { fatalError() }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("customers/\(customerId)/subscriptions/\(id)"))
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
    
    public func createTokenRequest(
        number: String = TestCardNumbers.maestro,
        expirationMonth: String = "10",
        expirationYear: String = "2030",
        cvc: String = "123") -> TokenRequest {
        TokenRequest(
            number: number,
            expirationMonth: expirationMonth,
            expirationYear: expirationYear,
            cvc: cvc
        )
    }
}
