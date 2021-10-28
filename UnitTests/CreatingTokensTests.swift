import XCTest
import Foundation
@testable import SecurionPay

final class CreatingTokensTests: XCTestCase {
    private var testExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        testExpectation = self.expectation(description: "Token")
        SecurionPay.shared.publicKey = SecurionPayAPI.publicKey
    }
    
    func testCreatingToken() {
        let tokenRequest = TokenRequest(
            number: TestCardNumbers.visa,
            expirationMonth: "10",
            expirationYear: "2023",
            cvc: "123"
        )
        
        SecurionPay.shared.createToken(with: tokenRequest) { (result, error) in

            let token = SecurionPayAPI.shared.getToken(with: result!.id)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), token.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), token.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, token.expirationMonth)
            XCTAssertEqual(tokenRequest.expirationYear, token.expirationYear)
            XCTAssertEqual("Visa", token.brand)
            
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
}
