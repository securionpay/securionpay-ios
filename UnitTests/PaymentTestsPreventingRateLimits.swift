import XCTest
import Foundation
@testable import SecurionPay

final class PaymentTestsPreventingRateLimits: XCTestCase {
    private var testExpectation: XCTestExpectation?
    private var checkoutManager: CheckoutManager!
    private var viewController: UIViewController!
    private var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        testExpectation = self.expectation(description: "Token")
        checkoutManager = CheckoutManager()
        viewController = UIViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        SecurionPay.shared.publicKey = SecurionPayAPI.publicKey
        SecurionPay.shared.bundleIdentifier = "com.securionpay.sdk.SecurionPay"
//        sleep(120) // wait two minutes to prevent rate limit
    }

    func testSuccessfulPaymentWithExistingToken() {
        let token = SecurionPayAPI.shared.createToken()
        let checkoutRequest = CheckoutRequestGenerator().generate(threeDS: false)
        let email = "test123@email.com"

        checkoutManager.pay(token: token, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            let charge = SecurionPayAPI().getCharge(with: result!.chargeId!)
            XCTAssertEqual(result!.chargeId, charge.id)
            XCTAssertEqual(10000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(token.first6, charge.card.first6)
            XCTAssertEqual(token.last4, charge.card.last4)
            XCTAssertEqual(token.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(token.expirationYear, charge.card.expYear)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testSuccessfulPaymentWithNonExistingToken() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest()
        let checkoutRequest = CheckoutRequestGenerator().generate(threeDS: false)
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            let charge = SecurionPayAPI().getCharge(with: result!.chargeId!)
            XCTAssertEqual(result!.chargeId, charge.id)
            XCTAssertEqual(10000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testLookupForSavedCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.maestro)
        let checkoutRequest = CheckoutRequestGenerator().generate(threeDS: false)
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, remember: true, navigationControllerFor3DS: viewController) { result, error in
            XCTAssertNotNil(result)
            XCTAssertNil(error)

            self.checkoutManager.lookup(email: email) { lookupResult, lookupError in
                guard let lookupResult = lookupResult else { XCTFail(); return }
                XCTAssertEqual("53", lookupResult.card.last2)
                XCTAssertEqual("maestro", lookupResult.card.brand)

                self.testExpectation?.fulfill()
            }
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testSuccessfulPaymentWithSavedCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.visa)
        let checkoutRequest = CheckoutRequestGenerator().generate(threeDS: false)
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, remember: true, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            let charge = SecurionPayAPI().getCharge(with: result!.chargeId!)
            XCTAssertEqual(result!.chargeId, charge.id)
            XCTAssertEqual(10000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)
            self.checkoutManager.savedToken(email: email) { token, tokenError in
                XCTAssertNotNil(token)
                XCTAssertNil(tokenError)
                let tokenData = SecurionPayAPI().getToken(with: token?.id ?? "")
                XCTAssertEqual(tokenData.expirationMonth, tokenRequest.expirationMonth)
                XCTAssertEqual(tokenData.expirationYear, tokenRequest.expirationYear)
                XCTAssertEqual(String(tokenRequest.number.prefix(6)), tokenData.first6)
                XCTAssertEqual(String(tokenRequest.number.suffix(4)), tokenData.last4)

                self.checkoutManager.pay(token: token!, checkoutRequest: checkoutRequest, email: email, remember: true, cvc: "123", sms: nil, navigationControllerFor3DS: self.viewController) { paymentResult, paymentError in
                    XCTAssertNotNil(paymentResult)
                    XCTAssertNil(paymentError)
                    let charge = SecurionPayAPI().getCharge(with: paymentResult!.chargeId!)
                    XCTAssertEqual(paymentResult!.chargeId, charge.id)
                    XCTAssertEqual(10000, charge.amount)
                    XCTAssertEqual("EUR", charge.currency)
                    XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
                    XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
                    XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
                    XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)

                    self.testExpectation?.fulfill()
                }
            }
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testSuccessfulPaymentOfDonation() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.visa)
        let checkoutRequest = CheckoutRequestGenerator().generateDonation()
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, amount: 3000, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            let charge = SecurionPayAPI().getCharge(with: result!.chargeId!)
            XCTAssertEqual(result!.chargeId, charge.id)
            XCTAssertEqual(3000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testSuccessfulPaymentOfSubscription() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.visa)
        let plan = SecurionPayAPI.shared.createPlan(amount: 10000, currency: "EUR")
        let checkoutRequest = CheckoutRequestGenerator().generateSubscription(planId: plan.id)
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, amount: plan.amount, currency: plan.currency, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            let subscription = SecurionPayAPI().getSubscription(with: result!.subscriptionId!, customerId: result!.customer!.id)
            XCTAssertEqual(result!.subscriptionId, subscription.id)
            XCTAssertEqual(subscription.planId, checkoutRequest.subscription!.planId)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPaymentWith3DSEnabledShouldPassWithNotEnrolledCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.visa)
        let checkoutRequest = CheckoutRequestGenerator().generate(
            threeDS: true,
            requireEnrolledCard: false,
            requireSuccessfulLiabilityShiftForEnrolledCard: false
        )
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            guard let result = result else { XCTFail(); return }
            let charge = SecurionPayAPI().getCharge(with: result.chargeId ?? "")
            XCTAssertEqual(result.chargeId, charge.id)
            XCTAssertEqual(10000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)
            XCTAssertEqual("not_possible", charge.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(false, charge.threeDSecureInfo?.enrolled)
            XCTAssertEqual(10000, charge.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", charge.threeDSecureInfo?.currency)
            
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPaymentWith3DSEnabledShouldPassWithEnrolledCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.VisaThreeD.frictionlessPassing2)
        let checkoutRequest = CheckoutRequestGenerator().generate(
            threeDS: true,
            requireEnrolledCard: false,
            requireSuccessfulLiabilityShiftForEnrolledCard: false
        )
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            let charge = SecurionPayAPI().getCharge(with: result!.chargeId!)
            XCTAssertEqual(result!.chargeId, charge.id)
            XCTAssertEqual(10000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)
            XCTAssertEqual("successful", charge.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(true, charge.threeDSecureInfo?.enrolled)
            XCTAssertEqual(10000, charge.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", charge.threeDSecureInfo?.currency)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPaymentWith3DSEnabledShouldPassWith3DSFailingCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.VisaThreeD.frictionlessFailing)
        let checkoutRequest = CheckoutRequestGenerator().generate(
            threeDS: true,
            requireEnrolledCard: false,
            requireSuccessfulLiabilityShiftForEnrolledCard: false
        )
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            let charge = SecurionPayAPI().getCharge(with: result!.chargeId!)
            XCTAssertEqual(result!.chargeId, charge.id)
            XCTAssertEqual(10000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)
            XCTAssertEqual("failed", charge.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(true, charge.threeDSecureInfo?.enrolled)
            XCTAssertEqual(10000, charge.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", charge.threeDSecureInfo?.currency)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPaymentWithRequireEnrolledShouldPassWith3DSFailingCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.VisaThreeD.frictionlessFailing)
        let checkoutRequest = CheckoutRequestGenerator().generate(
            threeDS: true,
            requireEnrolledCard: true,
            requireSuccessfulLiabilityShiftForEnrolledCard: false
        )
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            let charge = SecurionPayAPI().getCharge(with: result!.chargeId!)
            XCTAssertEqual(result!.chargeId, charge.id)
            XCTAssertEqual(10000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)
            XCTAssertEqual("failed", charge.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(true, charge.threeDSecureInfo?.enrolled)
            XCTAssertEqual(10000, charge.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", charge.threeDSecureInfo?.currency)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPaymentWithRequireEnrolledShouldFailWithNotEnrolledCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.visa)
        let checkoutRequest = CheckoutRequestGenerator().generate(
            threeDS: true,
            requireEnrolledCard: true,
            requireSuccessfulLiabilityShiftForEnrolledCard: false
        )
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.enrolledCardIsRequired, error?.code)
            XCTAssertEqual(.invalidRequest, error?.type)
            XCTAssertEqual("The charge requires cardholder authentication.", error!.message)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPaymentWithRequireEnrolledShouldPassWith3DSPassingCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.VisaThreeD.frictionlessPassing2)
        let checkoutRequest = CheckoutRequestGenerator().generate(
            threeDS: true,
            requireEnrolledCard: true,
            requireSuccessfulLiabilityShiftForEnrolledCard: false
        )
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            let charge = SecurionPayAPI().getCharge(with: result!.chargeId!)
            XCTAssertEqual(result!.chargeId, charge.id)
            XCTAssertEqual(10000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)
            XCTAssertEqual("successful", charge.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(true, charge.threeDSecureInfo?.enrolled)
            XCTAssertEqual(10000, charge.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", charge.threeDSecureInfo?.currency)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPaymentWithRequireEnrolledAndLiabilityShiftShouldFailWithNotEnrolledCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.visa)
        let checkoutRequest = CheckoutRequestGenerator().generate(
            threeDS: true,
            requireEnrolledCard: true,
            requireSuccessfulLiabilityShiftForEnrolledCard: true
        )
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.enrolledCardIsRequired, error?.code)
            XCTAssertEqual(.invalidRequest, error?.type)
            XCTAssertEqual("The charge requires cardholder authentication.", error!.message)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPaymentWithRequireEnrolledAndLiabilityShiftShouldFailWith3DSFailingCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.VisaThreeD.frictionlessFailing)
        let checkoutRequest = CheckoutRequestGenerator().generate(
            threeDS: true,
            requireEnrolledCard: true,
            requireSuccessfulLiabilityShiftForEnrolledCard: true
        )
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(result)
            XCTAssertEqual(.successfulLiabilityShiftIsRequired, error?.code)
            XCTAssertEqual(.invalidRequest, error?.type)
            XCTAssertEqual("The charge requires cardholder authentication.", error!.message)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPaymentWithRequireEnrolledAndLiabilityShiftShouldPassWith3DSPassingCard() {
        let tokenRequest = SecurionPayAPI.shared.createTokenRequest(number: TestCardNumbers.VisaThreeD.frictionlessPassing3)
        let checkoutRequest = CheckoutRequestGenerator().generate(
            threeDS: true,
            requireEnrolledCard: true,
            requireSuccessfulLiabilityShiftForEnrolledCard: true
        )
        let email = "test123@email.com"

        checkoutManager.pay(tokenRequest: tokenRequest, checkoutRequest: checkoutRequest, email: email, navigationControllerFor3DS: viewController) { (result, error) in
            XCTAssertNil(error)
            let charge = SecurionPayAPI().getCharge(with: result!.chargeId!)
            XCTAssertEqual(result!.chargeId, charge.id)
            XCTAssertEqual(10000, charge.amount)
            XCTAssertEqual("EUR", charge.currency)
            XCTAssertEqual(String(tokenRequest.number.prefix(6)), charge.card.first6)
            XCTAssertEqual(String(tokenRequest.number.suffix(4)), charge.card.last4)
            XCTAssertEqual(tokenRequest.expirationMonth, charge.card.expMonth)
            XCTAssertEqual(tokenRequest.expirationYear, charge.card.expYear)
            XCTAssertEqual("successful", charge.threeDSecureInfo?.liabilityShift)
            XCTAssertEqual(true, charge.threeDSecureInfo?.enrolled)
            XCTAssertEqual(10000, charge.threeDSecureInfo?.amount)
            XCTAssertEqual("EUR", charge.threeDSecureInfo?.currency)
            
            self.testExpectation?.fulfill()
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
}
