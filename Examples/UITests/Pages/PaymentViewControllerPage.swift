import XCTest

final class PaymentViewControllerPage: Page {
    var test: BaseTest!
    let pageIdentifier: String? = AccessibilityIdentifier.PaymentViewController.identifier
    
    init() {}
}

extension PaymentViewControllerPage {
    func assertEmailFocus() {
        XCTAssertTrue(test.textField(with: AccessibilityIdentifier.PaymentViewController.email).hasFocus())
    }
    
    func assertCardNumberFocus() {
        XCTAssertTrue(test.textField(with: AccessibilityIdentifier.PaymentViewController.cardNumber).hasFocus())
    }
    
    func assertExpirationFocus() {
        XCTAssertTrue(test.textField(with: AccessibilityIdentifier.PaymentViewController.expiration).hasFocus())
    }
    
    func assertCVCFocus() {
        XCTAssertTrue(test.textField(with: AccessibilityIdentifier.PaymentViewController.cvc).hasFocus())
    }
    
    func assertNoFocus() {
        XCTAssertFalse(test.textField(with: AccessibilityIdentifier.PaymentViewController.email).hasFocus())
        XCTAssertFalse(test.textField(with: AccessibilityIdentifier.PaymentViewController.cardNumber).hasFocus())
        XCTAssertFalse(test.textField(with: AccessibilityIdentifier.PaymentViewController.expiration).hasFocus())
        XCTAssertFalse(test.textField(with: AccessibilityIdentifier.PaymentViewController.cvc).hasFocus())
    }
    
    func assertError(error: String?) {
        XCTAssertEqual(test.label(with: AccessibilityIdentifier.PaymentViewController.errorLabel).label, error)
    }
    
    func assertEmailError(error: String?) {
        XCTAssertEqual(test.label(with: AccessibilityIdentifier.PaymentViewController.emailErrorLabel).label, error)
    }
    
    func assertCardError(error: String?) {
        XCTAssertEqual(test.label(with: AccessibilityIdentifier.PaymentViewController.cardErrorLabel).label, error)
    }
    
    func hideKeyboard() {
        test.label(with: AccessibilityIdentifier.PaymentViewController.titleLabel).tap()
    }
    
    func fillEmail(email: String, newline: Bool = true) {
        test.textField(with: AccessibilityIdentifier.PaymentViewController.email).tap()
        test.textField(with: AccessibilityIdentifier.PaymentViewController.email).clearText()
        test.textField(with: AccessibilityIdentifier.PaymentViewController.email).typeText(email)
        if newline {
            test.textField(with: AccessibilityIdentifier.PaymentViewController.email).typeText("\n")
        }
    }
    
    func fillCardNumber(number: String) {
        test.textField(with: AccessibilityIdentifier.PaymentViewController.cardNumber).tap()
        test.textField(with: AccessibilityIdentifier.PaymentViewController.cardNumber).clearText()
        test.textField(with: AccessibilityIdentifier.PaymentViewController.cardNumber).typeText(number)
    }
    
    func fillExpiration(month: Int, year: Int) {
        test.textField(with: AccessibilityIdentifier.PaymentViewController.expiration).tap()
        test.textField(with: AccessibilityIdentifier.PaymentViewController.expiration).clearText()
        test.textField(with: AccessibilityIdentifier.PaymentViewController.expiration).typeText("\(month)\(year)")
    }
    
    func fillCVC(cvc: Int) {
        test.textField(with: AccessibilityIdentifier.PaymentViewController.cvc).tap()
        test.textField(with: AccessibilityIdentifier.PaymentViewController.cvc).typeText("\(cvc)")
    }
    
    func pay<T: Page>() -> T {
        test.button(with: AccessibilityIdentifier.PaymentViewController.button).tap()
        Sleep.seconds(10)
        return T(test: test)
    }
    
    func close<T: Page>() -> T {
        test.button(with: AccessibilityIdentifier.PaymentViewController.closeButton).tap()
        return T(test: test)
    }
    
    func selectCell(with title: String) {
        let collection = XCUIApplication().collectionViews.firstMatch
        collection.cells[AccessibilityIdentifier.PaymentViewController.donationCell(with: title)].tap()
    }
    
    func saveForFurtherUse(save: Bool) {
        let element = XCUIApplication().switches[AccessibilityIdentifier.PaymentViewController.rememberSwitch]
        guard let value = element.value as? String else { return }
        if value == "0" && save || value == "1" && !save {
            element.tap()
        }
    }
    
    func assertPaymentButton(title: String) {
        let button = test.button(with: AccessibilityIdentifier.PaymentViewController.button)
        XCTAssertEqual(title, button.label)
    }
}
