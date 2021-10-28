import XCTest
import Foundation
@testable import SecurionPay

final class ValidationErrorsTests: XCTestCase {
    private var testExpectation: XCTestExpectation?
    private var navController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        testExpectation = self.expectation(description: "Token")
        navController = UINavigationController(rootViewController: UIViewController())
        SecurionPay.shared.publicKey = SecurionPayAPI.publicKey
    }
    
    func testCreatingTokenWithInvalidCardNumber() {
        let tokenRequest = TokenRequest(
            number: "424",
            expirationMonth: "10",
            expirationYear: "2023",
            cvc: "123"
        )
        
        SecurionPay.shared.createToken(with: tokenRequest) { (result, error) in
            XCTAssertEqual(SecurionPayError.ErrorCode.invalidNumber, error?.code)
            XCTAssertEqual(SecurionPayError.ErrorType.cardError, error?.type)
            XCTAssertEqual("The card number is not a valid credit card number.", error?.message)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testCreatingTokenWithInvalidExpirationMonth() {
        let tokenRequest = TokenRequest(
            number: "4242424242424242",
            expirationMonth: "15",
            expirationYear: "2023",
            cvc: "123"
        )
        
        SecurionPay.shared.createToken(with: tokenRequest) { (result, error) in
            XCTAssertEqual(SecurionPayError.ErrorCode.invalidExpiryMonth, error?.code)
            XCTAssertEqual(SecurionPayError.ErrorType.cardError, error?.type)
            XCTAssertEqual("The card's expiration month is invalid.", error?.message)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testCreatingTokenWithInvalidExpirationYear() {
        let tokenRequest = TokenRequest(
            number: "4242424242424242",
            expirationMonth: "10",
            expirationYear: "201",
            cvc: "123"
        )
        
        SecurionPay.shared.createToken(with: tokenRequest) { (result, error) in
            XCTAssertEqual(SecurionPayError.ErrorCode.invalidExpiryYear, error?.code)
            XCTAssertEqual(SecurionPayError.ErrorType.cardError, error?.type)
            XCTAssertEqual("The card's expiration year is invalid.", error?.message)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testCreatingTokenWithExpiredCard() {
        let tokenRequest = TokenRequest(
            number: "4242424242424242",
            expirationMonth: "10",
            expirationYear: "2010",
            cvc: "123"
        )
        
        SecurionPay.shared.createToken(with: tokenRequest) { (result, error) in
            XCTAssertEqual(SecurionPayError.ErrorCode.expiredCard, error?.code)
            XCTAssertEqual(SecurionPayError.ErrorType.cardError, error?.type)
            XCTAssertEqual("The card has expired.", error?.message)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsuccessfulPaymentBecauseOfInvalidNumber() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ValidationError.invalidNumber)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        CheckoutManager.shared.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.invalidNumber, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The card number is not a valid credit card number.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testUnsuccessfulPaymentBecauseOfInvalidExpiryMonth() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ValidationError.invaldExpiryMonth)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        CheckoutManager.shared.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.invalidExpiryMonth, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The card's expiration month is invalid.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testUnsuccessfulPaymentBecauseOfInvalidExpiryYear() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ValidationError.invalidExpiryYear)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        CheckoutManager.shared.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.invalidExpiryYear, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The card's expiration year is invalid.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testUnsuccessfulPaymentBecauseOfInvalidCVC() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ValidationError.invalidCVC)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        CheckoutManager.shared.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.invalidCVC, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("Your card's security code is invalid.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsuccessfulPaymentBecauseOfExpiredCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ValidationError.expiredCard)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        CheckoutManager.shared.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.expiredCard, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The card has expired.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
}
