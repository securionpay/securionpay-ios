import XCTest

class ThreeDSecureCheckoutTests: BaseTest {
    override func setUp() {
        super.setUp()
        checkoutPage.typePublicKey(key: SecurionPayAPI.publicKey)
        checkoutPage.clearSavedCards()
    }
    
    func testChallengeText() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generate(threeDS: true))
        page = checkoutPage.payment()
        
        page.assertPaymentButton(title: "Pay €100.00")
        page.fillEmail(email: "test@example.com")
        page.fillCardNumber(number: TestCardNumbers.VisaThreeD.challengeText)
        page.fillExpiration(month: 6, year: 2026)
        page.fillCVC(cvc: 123)
        page.saveForFurtherUse(save: false)

        threeDPage = page.pay()
        threeDPage.typeCode(code: "1234")
        checkoutPage = threeDPage.submit()

        page = checkoutPage.payment()

        let charge = SecurionPayAPI().getCharge(with: lastSuccededCharge!)
        XCTAssertEqual(lastSuccededCharge!, charge.id)
        XCTAssertEqual(10000, charge.amount)
        XCTAssertEqual("EUR", charge.currency)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengeText.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengeText.suffix(4)), charge.card.last4)
        XCTAssertEqual("06", charge.card.expMonth)
        XCTAssertEqual("2026", charge.card.expYear)
    }
    
    func testChallenge() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generate(threeDS: true))
        page = checkoutPage.payment()
        
        page.assertPaymentButton(title: "Pay €100.00")
        page.fillEmail(email: "test@example.com")
        page.fillCardNumber(number: TestCardNumbers.VisaThreeD.challengePassing)
        page.fillExpiration(month: 6, year: 2026)
        page.fillCVC(cvc: 123)
        page.saveForFurtherUse(save: false)

        threeDPage = page.pay()
        checkoutPage = threeDPage.continue()

        page = checkoutPage.payment()

        let charge = SecurionPayAPI().getCharge(with: lastSuccededCharge!)
        XCTAssertEqual(lastSuccededCharge!, charge.id)
        XCTAssertEqual(10000, charge.amount)
        XCTAssertEqual("EUR", charge.currency)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengePassing.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengePassing.suffix(4)), charge.card.last4)
        XCTAssertEqual("06", charge.card.expMonth)
        XCTAssertEqual("2026", charge.card.expYear)
    }
    
    func testFrictionless() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generate(threeDS: true))
        page = checkoutPage.payment()
        
        page.assertPaymentButton(title: "Pay €100.00")
        page.fillEmail(email: "test@example.com")
        page.fillCardNumber(number: TestCardNumbers.VisaThreeD.frictionlessPassing)
        page.fillExpiration(month: 6, year: 2026)
        page.fillCVC(cvc: 123)
        page.saveForFurtherUse(save: false)
        checkoutPage = page.pay()
                
        page = checkoutPage.payment()
        
        let charge = SecurionPayAPI().getCharge(with: lastSuccededCharge!)
        XCTAssertEqual(lastSuccededCharge!, charge.id)
        XCTAssertEqual(10000, charge.amount)
        XCTAssertEqual("EUR", charge.currency)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessPassing.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessPassing.suffix(4)), charge.card.last4)
        XCTAssertEqual("06", charge.card.expMonth)
        XCTAssertEqual("2026", charge.card.expYear)
    }
    
    func testSubscription() {
        let plan = SecurionPayAPI().createPlan(amount: 1000, currency: "EUR")
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generateSubscription(planId: plan.id, threeDS: true))
        page = checkoutPage.payment()
        
        page.assertPaymentButton(title: "Pay €10.00")
        page.fillCardNumber(number: TestCardNumbers.VisaThreeD.frictionlessPassing2)
        page.fillExpiration(month: 6, year: 2026)
        page.fillCVC(cvc: 123)
        page.saveForFurtherUse(save: true)
        page.fillEmail(email: "example@test.com")
        checkoutPage = page.pay()
                
        page = checkoutPage.payment()
        
        let charge = SecurionPayAPI().getCharge(with: lastSuccededCharge!)
        XCTAssertEqual(lastSuccededCharge!, charge.id)
        XCTAssertEqual(1000, charge.amount)
        XCTAssertEqual("EUR", charge.currency)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessPassing2.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessPassing2.suffix(4)), charge.card.last4)
        XCTAssertEqual("06", charge.card.expMonth)
        XCTAssertEqual("2026", charge.card.expYear)
        XCTAssertEqual(lastSuccededSubscription!, charge.subscriptionId)
        
        checkoutPage = page.close()
    }
    
    func testDonations() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generateDonation())
        page = checkoutPage.payment()

        page.selectCell(with: "€30.00")
        page = page.pay()
        page.hideKeyboard()
        page.assertPaymentButton(title: "Pay €30.00")
        page.fillEmail(email: "test@example.com")
        page.fillCardNumber(number: TestCardNumbers.VisaThreeD.frictionlessPassing3)
        page.fillExpiration(month: 6, year: 2026)
        page.fillCVC(cvc: 123)
        page.saveForFurtherUse(save: false)
        checkoutPage = page.pay()

        page = checkoutPage.payment()
        
        let charge = SecurionPayAPI().getCharge(with: lastSuccededCharge!)
        XCTAssertEqual(lastSuccededCharge!, charge.id)
        XCTAssertEqual(3000, charge.amount)
        XCTAssertEqual("EUR", charge.currency)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessPassing3.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessPassing3.suffix(4)), charge.card.last4)
        XCTAssertEqual("06", charge.card.expMonth)
        XCTAssertEqual("2026", charge.card.expYear)
        checkoutPage = page.close()
    }
    
    func testPaymentWithRequireEnrolledAndLiabilityShiftShouldFailWith3DSFailingCardFrictionless() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generate(threeDS: true))
        page = checkoutPage.payment()
        
        page.assertPaymentButton(title: "Pay €100.00")
        page.fillCardNumber(number: TestCardNumbers.VisaThreeD.frictionlessFailing)
        page.fillExpiration(month: 6, year: 2026)
        page.fillCVC(cvc: 123)
        page.saveForFurtherUse(save: true)
        page.fillEmail(email: "example@test.com")
        page = page.pay()
                
        page.assertError(error: "The charge requires cardholder authentication.")
    }
    
    func testPaymentWithRequireEnrolledAndLiabilityShiftShouldFailWith3DSFailingCardChallenge() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generate(threeDS: true))
        page = checkoutPage.payment()
        
        page.assertPaymentButton(title: "Pay €100.00")
        page.fillEmail(email: "test@example.com")
        page.fillCardNumber(number: TestCardNumbers.VisaThreeD.challengeText)
        page.fillExpiration(month: 6, year: 2026)
        page.fillCVC(cvc: 123)
        page.saveForFurtherUse(save: false)

        threeDPage = page.pay()
        threeDPage.typeCode(code: "1111")
        page = threeDPage.submit()
        
        page.assertError(error: "The charge requires cardholder authentication.")
    }
}
