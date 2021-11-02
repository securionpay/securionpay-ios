import XCTest
import Foundation
@testable import SecurionPay

final class PaymentTests: XCTestCase {
    private var testExpectation: XCTestExpectation?
    private var checkoutManager: CheckoutManager!
    private var viewController: UIViewController!
    private var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        testExpectation = self.expectation(description: "Token")
        viewController = UIViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        SecurionPay.shared.publicKey = SecurionPayAPI.publicKey
        SecurionPay.shared.bundleIdentifier = "com.securionpay.sdk.SecurionPay"
    }
    
    func testUnsupportedValueTermsAndConditions() {
        let checkoutRequest = CheckoutRequestGenerator().generate(termsAndConditionsUrl: "url")
        SecurionPay.shared.showCheckoutViewController(in: viewController, checkoutRequest: checkoutRequest) { result, error in
            XCTAssertNil(result)
            XCTAssertEqual(.unsupportedValue, error?.code)
            XCTAssertEqual(.sdk, error?.type)
            XCTAssertEqual("Unsupported value: termsAndConditionsUrl", error!.message)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsupportedValueCustomerId() {
        let checkoutRequest = CheckoutRequestGenerator().generate(customerId: "cudstomed")
        SecurionPay.shared.showCheckoutViewController(in: viewController, checkoutRequest: checkoutRequest) { result, error in
            XCTAssertNil(result)
            XCTAssertEqual(.unsupportedValue, error?.code)
            XCTAssertEqual(.sdk, error?.type)
            XCTAssertEqual("Unsupported value: customerId", error!.message)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testUnsupportedValuecrossSaleOfferIds() {
        let checkoutRequest = CheckoutRequestGenerator().generate(crossSaleOfferIds: ["1","2","23"])
        SecurionPay.shared.showCheckoutViewController(in: viewController, checkoutRequest: checkoutRequest) { result, error in
            XCTAssertNil(result)
            XCTAssertEqual(.unsupportedValue, error?.code)
            XCTAssertEqual(.sdk, error?.type)
            XCTAssertEqual("Unsupported value: crossSaleOfferIds", error!.message)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testAuthenticateFrictionlessPassing() {
        let token = SecurionPayAPI().createToken(number: TestCardNumbers.VisaThreeD.frictionlessPassing)
        
        SecurionPay.shared.authenticate(token: token, amount: 10000, currency: "EUR", navigationControllerFor3DS: navigationController) { token, error in
            XCTAssertEqual(true, token?.threeDSecureInfo?.enrolled)
            XCTAssertEqual(.successful, token?.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(10000, token?.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", token?.threeDSecureInfo?.currency)
            XCTAssertNil(error)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testAuthenticateFrictionlessPassing2() {
        let token = SecurionPayAPI().createToken(number: TestCardNumbers.VisaThreeD.frictionlessPassing2)
        
        SecurionPay.shared.authenticate(token: token, amount: 10000, currency: "EUR", navigationControllerFor3DS: navigationController) { token, error in
            XCTAssertEqual(true, token?.threeDSecureInfo?.enrolled)
            XCTAssertEqual(.successful, token?.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(10000, token?.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", token?.threeDSecureInfo?.currency)
            XCTAssertNil(error)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testAuthenticateFrictionlessPassing3() {
        let token = SecurionPayAPI().createToken(number: TestCardNumbers.VisaThreeD.frictionlessPassing3)
        
        SecurionPay.shared.authenticate(token: token, amount: 10000, currency: "EUR", navigationControllerFor3DS: navigationController) { token, error in
            XCTAssertEqual(true, token?.threeDSecureInfo?.enrolled)
            XCTAssertEqual(.successful, token?.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(10000, token?.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", token?.threeDSecureInfo?.currency)
            XCTAssertNil(error)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testAuthenticateFrictionlessFailing() {
        let token = SecurionPayAPI().createToken(number: TestCardNumbers.VisaThreeD.frictionlessFailing)
        
        SecurionPay.shared.authenticate(token: token, amount: 10000, currency: "EUR", navigationControllerFor3DS: navigationController) { token, error in
            XCTAssertEqual(true, token?.threeDSecureInfo?.enrolled)
            XCTAssertEqual(.failed, token?.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(10000, token?.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", token?.threeDSecureInfo?.currency)
            XCTAssertNil(error)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testAuthenticateNotEnrolled() {
        let token = SecurionPayAPI().createToken(number: TestCardNumbers.mastercard)
        
        SecurionPay.shared.authenticate(token: token, amount: 10000, currency: "EUR", navigationControllerFor3DS: navigationController) { token, error in
            XCTAssertEqual(false, token?.threeDSecureInfo?.enrolled)
            XCTAssertEqual(.notPossible, token?.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(10000, token?.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", token?.threeDSecureInfo?.currency)
            XCTAssertNil(error)
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testCheckoutRequestDetails() {
        let plan = SecurionPayAPI.shared.createPlan(amount: 10000, currency: "EUR")
        let checkoutManager = CheckoutManager()
        let checkoutRequest = CheckoutRequestGenerator().generateSubscription(planId: plan.id)

        checkoutManager.checkoutRequestDetails(checkoutRequest: checkoutRequest) { result, error in
            XCTAssertNil(error)
            let plan = SecurionPayAPI().getPlan(with: checkoutRequest.subscription!.planId)
            XCTAssertEqual(plan.amount, result?.subscription?.plan.amount)
            XCTAssertEqual(plan.currency, result?.subscription?.plan.currency)
            
            self.testExpectation?.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
}
