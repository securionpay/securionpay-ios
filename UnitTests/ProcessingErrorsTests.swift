import XCTest
import Foundation
@testable import SecurionPay

final class ProcessingErrorsTests: XCTestCase {
    private var testExpectation: XCTestExpectation?
    private var checkoutManager: CheckoutManager!
    private var navController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        testExpectation = self.expectation(description: "Token")
        checkoutManager = CheckoutManager()
        navController = UINavigationController(rootViewController: UIViewController())
        SecurionPay.shared.publicKey = SecurionPayAPI.publicKey
        SecurionPay.shared.bundleIdentifier = "com.securionpay.sdk.SecurionPay"
    }
    
    func testUnsuccessfulPaymentBecauseOfInvalidEmail() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.visa)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test12email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.invalidEmail, error?.code)
            XCTAssertEqual(.invalidRequest, error?.type)
            XCTAssertEqual("E-mail must be valid e-mail address", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsuccessfulPaymentBecauseOfProcessingError() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ProcessingError.processingError)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.processingError, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("An error occurred while processing the card.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsuccessfulPaymentBecauseOfAuthenticationRequired() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ProcessingError.authenticationRequired)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.authenticationRequired, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The charge requires authentication.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsuccessfulPaymentBecauseOfCardDeclined() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ProcessingError.cardDeclined)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.cardDeclined, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The card was declined.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsuccessfulPaymentBecauseOfSuspectedFraud() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ProcessingError.suspectedFraud)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.suspectedFraud, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The charge is suspected to be fraudulent.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsuccessfulPaymentBecauseOfLostOrStolen() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ProcessingError.lostOrStolen)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.lostOrStolen, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The card is marked as lost or stolen.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsuccessfulPaymentBecauseOfInsufficientFunds() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ProcessingError.insufficientFunds)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.insufficientFunds, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The charge amount exceeds the available funds or the card's credit limit.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsuccessfulPaymentBecauseOfIncorrectCVC() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.ProcessingError.incorrectCVC)
        let checkoutRequest = CheckoutRequestGenerator().generate()
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: navController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.incorrectCVC, error?.code)
            XCTAssertEqual(.cardError, error?.type)
            XCTAssertEqual("The card's security code failed verification.", error!.message)
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
}
