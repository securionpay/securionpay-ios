import Foundation
import CryptoKit

final internal class APIProvider {
    private enum Endpoint {
        case API
        case BackOffice
        
        var path: String {
            switch(self) {
            case .API: return APIConfig.apiURL
            case .BackOffice: return APIConfig.backOfficeURL
            }
        }
    }
    
    private enum Method: String {
        case POST
        case GET
    }
    
    private let session: URLSession = URLSession(configuration: .default)
    
    internal func createToken(
        with request: TokenRequest,
        completion: @escaping (Token?, SecurionPayError?) -> Void) {
            performAPICall(method: .POST, endpoint: .API, path: "tokens", request: request, completion: completion)
        }
    
    internal func pay(
        token: Token,
        checkoutRequest: CheckoutRequest,
        sessionId: String,
        email: String,
        remember: Bool,
        cvc: String?,
        sms: SMS?,
        amount: Int?,
        completion: @escaping (PaymentResult?, SecurionPayError?) -> Void) {
            let request = PaymentRequest(
                key: SecurionPay.shared.publicKey!,
                email: email,
                checkoutRequest: checkoutRequest,
                tokenID: token.id,
                sessionID: sessionId,
                rememberMe: remember,
                cvc: cvc,
                sms: sms,
                customAmount: amount
            )
            performAPICall(method: .POST, endpoint: .BackOffice, path: "checkout/pay", request: request, completion: completion)
        }
    
    internal func checkoutRequestDetails(checkoutRequest: CheckoutRequest, completion: @escaping (CheckoutRequestDetails?, SecurionPayError?) -> Void) {
        let request = CheckoutRequestDetailsRequest(key: SecurionPay.shared.publicKey!, checkoutRequest: checkoutRequest.content)
        performAPICall(method: .POST, endpoint: .BackOffice, path: "checkout/forms", request: request, completion: completion)
    }
    
    internal func lookup(email: String, completion: @escaping (LookupResult?, SecurionPayError?) -> Void) {
        let request = LookupRequest(key: SecurionPay.shared.publicKey!, email: email)
        performAPICall(method: .POST, endpoint: .BackOffice, path: "checkout/lookup", request: request, completion: completion)
    }
    
    internal func savedToken(email: String, completion: @escaping (Token?, SecurionPayError?) -> Void) {
        let request = SavedTokenRequest(key: SecurionPay.shared.publicKey!, email: email, paymentUserAgent: UserAgentProvider.short)
        performAPICall(method: .POST, endpoint: .BackOffice, path: "checkout/tokens", request: request, completion: completion)
    }
    
    internal func sendSMS(email: String, completion: @escaping (SMS?, SecurionPayError?) -> Void) {
        let request = SendSMSRequest(key: SecurionPay.shared.publicKey!, email: email)
        performAPICall(method: .POST, endpoint: .BackOffice, path: "checkout/verification-sms", request: request, completion: completion)
    }
    
    internal func verifySMS(code: String, sms: SMS, completion: @escaping (VerifySMSResponse?, SecurionPayError?) -> Void) {
        let request = VerifySMSRequest(code: code)
        performAPICall(method: .POST, endpoint: .BackOffice, path: "checkout/verification-sms/\(sms.id)", request: request, completion: completion)
    }
    
    internal func threeDSecureCheck(token: Token, amount: Int, currency: String, completion: @escaping (ThreeDSecureInitResult?, SecurionPayError?) -> Void) {
        let request = ThreeDSecureRequest(card: token.id, amount: amount, currency: currency)
        performAPICall(method: .POST, endpoint: .API, path: "3d-secure", request: request, completion: completion)
    }
    
    internal func threeDSecureAuthenticate(token: Token, authenticationParameters: String, completion: @escaping (ThreeDSecureAuthentication?, SecurionPayError?) -> Void) {
        let request = ThreeDSecureAuthenticateRequest(token: token.id, clientAuthRequest: authenticationParameters.toBase64())
        performAPICall(method: .POST, endpoint: .API, path: "3d-secure/v2/authenticate", request: request, completion: completion)
    }
    
    internal func threeDSecureComplete(token: Token, completion: @escaping (Token?, SecurionPayError?) -> Void) {
        let request = ThreeDSecureCompleteRequest(token: token.id)
        performAPICall(method: .POST, endpoint: .API, path: "3d-secure/v2/challenge-complete", request: request, completion: completion)
    }
    
    private func performAPICall<Request: Encodable, Response: Codable>(
        method: Method,
        endpoint: Endpoint,
        path: String,
        request: Request,
        completion: @escaping (Response?, SecurionPayError?) -> Void) {
            let url = URL(string: endpoint.path)!
            
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(request)
                urlRequest.httpBody = data
                urlRequest.setValue(APIConfig.backOfficeURL,
                                    forHTTPHeaderField: "Referer")
                urlRequest.setValue("application/json",
                                    forHTTPHeaderField: "Content-Type")
                if endpoint == .API {
                    urlRequest.setValue(
                        "Basic \(Data(((SecurionPay.shared.publicKey ?? "") + ":").utf8).base64EncodedString())",
                        forHTTPHeaderField: "Authorization")
                }
                urlRequest.setValue(UserAgentProvider.userAgent, forHTTPHeaderField: "user-agent")
            } catch {
                DispatchQueue.main.async {
                    completion(nil, .unknown)
                    return
                }
            }
            let task = self.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if let _ = error {
                        completion(nil, SecurionPayError(type: .unknown, code: .unknown, message: "ab"))
                    } else if let data = data {
                        let decoder = JSONDecoder()
                        if let decodedError = try? decoder.decode(GatewayErrorResponse.self, from: data) {
                            completion(nil, decodedError.toSecurionPayError())
                        } else if let decodedAPIError = try? decoder.decode(APIErrorResponse.self, from: data) {
                            completion(nil, decodedAPIError.toSecurionPayError())
                        } else if let simpleError = try? decoder.decode(SimpleAPIErrorResponse.self, from: data) {
                            completion(nil, simpleError.toSecurionPayError())
                        } else if let decodedToken = try? decoder.decode(Response.self, from: data) {
                            completion(decodedToken, nil)
                        } else {
                            completion(nil, SecurionPayError(type: .unknown, code: .unknown, message: String(data: data, encoding: .utf8) ?? ""))
                        }
                    }
                }
            })
            
            task.resume()
        }
        
    private struct APIErrorResponse: Codable {
        let error: SecurionPayError
        
        func toSecurionPayError() -> SecurionPayError {
            SecurionPayError(type: error.type, code: error.code, message: error.message)
        }
    }
    
    private struct SimpleAPIErrorResponse: Codable {
        let error: String
        
        func toSecurionPayError() -> SecurionPayError {
            SecurionPayError(type: .unknown, code: SecurionPayError.ErrorCode(rawValue: error), message: .empty)
        }
    }
    
    private struct GatewayErrorResponse: Codable {
        let error: String
        let errorMessage: String
        
        func toSecurionPayError() -> SecurionPayError {
            SecurionPayError(type: .unknown, code: nil, message: errorMessage)
        }
    }
}
