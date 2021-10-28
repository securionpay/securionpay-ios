import XCTest

class CheckoutViewControllerTests: BaseTest {
    override func setUp() {
        super.setUp()
        checkoutPage.typePublicKey(key: SecurionPayAPI.publicKey)
        checkoutPage.clearSavedCards()
    }
    
    func testValidationErrors() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generate())
        page = checkoutPage.payment()
        
        page.fillEmail(email: "test@example.com")
        page.fillExpiration(month: 6, year: 2025)
        page.fillCVC(cvc: 123)
        
        let cases = [
            (TestCardNumbers.ValidationError.expiredCard, "The card has expired."),
            (TestCardNumbers.ValidationError.invalidCVC, "Your card's security code is invalid."),
            (TestCardNumbers.ValidationError.invalidExpiryMonth, "The card's expiration month is invalid."),
            (TestCardNumbers.ValidationError.invalidExpiryYear, "The card's expiration year is invalid."),
            (TestCardNumbers.ValidationError.invalidNumber, "The card number is not a valid credit card number.")
        ]
        
        cases.forEach {
            page.fillCardNumber(number: $0.0)
            page = page.pay()
            page.assertCardError(error: $0.1)
        }
    }
    
    func testProcessingErrors() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generate())
        page = checkoutPage.payment()
        
        page.fillEmail(email: "test@example.com")
        page.fillExpiration(month: 6, year: 2025)
        page.fillCVC(cvc: 123)
        
        var cases = [
            (TestCardNumbers.ProcessingError.incorrectCVC, "The card's security code failed verification."),
            (TestCardNumbers.ProcessingError.cardDeclined, "The card was declined."),
            (TestCardNumbers.ProcessingError.lostOrStolen, "The card is marked as lost or stolen.")
        ]
        
        cases.forEach {
            page.fillCardNumber(number: $0.0)
            page = page.pay()
            page.assertCardError(error: $0.1)
        }
        
        cases = [

            (TestCardNumbers.ProcessingError.insufficientFunds, "The charge amount exceeds the available funds or the card's credit limit."),
            (TestCardNumbers.ProcessingError.suspectedFraud, "The charge is suspected to be fraudulent."),
            (TestCardNumbers.ProcessingError.processingError, "An error occurred while processing the card."),
            (TestCardNumbers.ProcessingError.authenticationRequired, "The charge requires cardholder authentication.")
        ]
        
        cases.forEach {
            page.fillCardNumber(number: $0.0)
            page = page.pay()
            page.assertError(error: $0.1)
        }
        
        page.fillEmail(email: "example.com")
        page.fillCardNumber(number: TestCardNumbers.mastercard)
        page = page.pay()
        page.assertEmailError(error: "")
    }
    
    func testFocusSwitching() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generate())
        page = checkoutPage.payment()
        page.assertEmailFocus()
        page.hideKeyboard()
        page.assertNoFocus()
        
        page.fillEmail(email: "test@example.com")
        page.assertCardNumberFocus()
        page.hideKeyboard()

        TestCardNumbers.all.forEach {
            page.fillCardNumber(number: $0)
            page.assertExpirationFocus()
            page.hideKeyboard()
        }
        
        [(6,2021), (2,21), (11,24), (12,99), (3,2099)].forEach {
            page.fillExpiration(month: $0.0, year: $0.1)
            page.assertCVCFocus()
            page.hideKeyboard()
        }
        
        page.fillCVC(cvc: 123)
        page.hideKeyboard()
    }
    
    func testCardRemembering() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generate(rememberMe: true))
        page = checkoutPage.payment()
        
        page.assertPaymentButton(title: "Pay €100.00")
        page.fillEmail(email: "test@example.com")
        page.fillCardNumber(number: TestCardNumbers.mastercard)
        page.fillExpiration(month: 6, year: 2026)
        page.fillCVC(cvc: 123)
        checkoutPage = page.pay()
                
        page = checkoutPage.payment()
        
        var charge = SecurionPayAPI().getCharge(with: lastSuccededCharge!)
        XCTAssertEqual(lastSuccededCharge!, charge.id)
        XCTAssertEqual(10000, charge.amount)
        XCTAssertEqual("EUR", charge.currency)
        XCTAssertEqual(String(TestCardNumbers.mastercard.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.mastercard.suffix(4)), charge.card.last4)
        XCTAssertEqual("06", charge.card.expMonth)
        XCTAssertEqual("2026", charge.card.expYear)
        
        page.hideKeyboard()
        
        page.assertPaymentButton(title: "Pay €100.00")
        page.fillCardNumber(number: TestCardNumbers.visa)
        page.fillExpiration(month: 12, year: 2025)
        page.fillCVC(cvc: 123)
        page.fillEmail(email: "test2@example.com")
        page.saveForFurtherUse(save: true)
        page.hideKeyboard()
        checkoutPage = page.pay()
        
        page = checkoutPage.payment()
        
        charge = SecurionPayAPI().getCharge(with: lastSuccededCharge!)
        XCTAssertEqual(lastSuccededCharge!, charge.id)
        XCTAssertEqual(10000, charge.amount)
        XCTAssertEqual("EUR", charge.currency)
        XCTAssertEqual(String(TestCardNumbers.visa.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.visa.suffix(4)), charge.card.last4)
        XCTAssertEqual("12", charge.card.expMonth)
        XCTAssertEqual("2025", charge.card.expYear)
        
        page.hideKeyboard()
        
        page.fillEmail(email: "test2@example.com", newline: false)
        page.hideKeyboard()
        
        page.fillEmail(email: "TEST@example.com", newline: false)
        page.hideKeyboard()
        page.fillCVC(cvc: 123)

        checkoutPage = page.pay()
        checkoutPage.clearSavedCards()
        
        charge = SecurionPayAPI().getCharge(with: lastSuccededCharge!)
        XCTAssertEqual(lastSuccededCharge!, charge.id)
        XCTAssertEqual(10000, charge.amount)
        XCTAssertEqual("EUR", charge.currency)
        XCTAssertEqual(String(TestCardNumbers.mastercard.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.mastercard.suffix(4)), charge.card.last4)
        XCTAssertEqual("06", charge.card.expMonth)
        XCTAssertEqual("2026", charge.card.expYear)
        
        page = checkoutPage.payment()
        
        page.hideKeyboard()
        checkoutPage = page.close()
    }
    
    func testSubscription() {
        let plan = SecurionPayAPI().createPlan(amount: 1000, currency: "EUR")
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generateSubscription(planId: plan.id))
        page = checkoutPage.payment()
        
        page.assertPaymentButton(title: "Pay €10.00")
        page.fillCardNumber(number: TestCardNumbers.mastercard)
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
        XCTAssertEqual(String(TestCardNumbers.mastercard.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.mastercard.suffix(4)), charge.card.last4)
        XCTAssertEqual("06", charge.card.expMonth)
        XCTAssertEqual("2026", charge.card.expYear)
        XCTAssertEqual(lastSuccededSubscription!, charge.subscriptionId)
        
        checkoutPage = page.close()
    }
    
    func testDonations() {
        checkoutPage.typeCheckoutRequest(request: CheckoutRequestGenerator().generateDonation())
        page = checkoutPage.payment()

        page.selectCell(with: "€20.00")
        page = page.pay()
        page.hideKeyboard()
        page.assertPaymentButton(title: "Pay €20.00")
        page.fillEmail(email: "test@example.com")
        page.fillCardNumber(number: TestCardNumbers.mastercard)
        page.fillExpiration(month: 6, year: 2026)
        page.fillCVC(cvc: 123)
        page.saveForFurtherUse(save: false)
        checkoutPage = page.pay()

        page = checkoutPage.payment()
        
        let charge = SecurionPayAPI().getCharge(with: lastSuccededCharge!)
        XCTAssertEqual(lastSuccededCharge!, charge.id)
        XCTAssertEqual(2000, charge.amount)
        XCTAssertEqual("EUR", charge.currency)
        XCTAssertEqual(String(TestCardNumbers.mastercard.prefix(6)), charge.card.first6)
        XCTAssertEqual(String(TestCardNumbers.mastercard.suffix(4)), charge.card.last4)
        XCTAssertEqual("06", charge.card.expMonth)
        XCTAssertEqual("2026", charge.card.expYear)
        checkoutPage = page.close()
    }
}
