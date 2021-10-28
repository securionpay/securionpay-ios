import XCTest

final class CustomFormPage: Page {
    var test: BaseTest!
    let pageIdentifier: String? = "CustomFormViewController"
    
    init() {}
}

extension CustomFormPage {
    func switchToCheckout<T: Page>() -> T {
        XCUIApplication().buttons["Checkout"].tap()
        return T(test: test)
    }
    
    func typePublicKey(key: String) {
        XCUIApplication().textFields["PublicKey"].tap()
        XCUIApplication().textFields["PublicKey"].clearText()
        XCUIApplication().textFields["PublicKey"].tap()
        XCUIApplication().textFields["PublicKey"].typeText(key)
    }
        
    func payment<T: Page>() -> T{
        XCUIApplication().buttons["Payment"].tap()
        Sleep.seconds(10)
        return T(test: test)
    }
    
    func typeCardNumber(value: String) {
        XCUIApplication().textFields["CardNumber"].tap()
        XCUIApplication().textFields["CardNumber"].clearText()
        XCUIApplication().textFields["CardNumber"].tap()
        XCUIApplication().textFields["CardNumber"].typeText(value)
    }
    
    func typeExpMonth(value: String) {
        XCUIApplication().textFields["ExpMonth"].tap()
        XCUIApplication().textFields["ExpMonth"].clearText()
        XCUIApplication().textFields["ExpMonth"].tap()
        XCUIApplication().textFields["ExpMonth"].typeText(value)
    }
    
    func typeExpYear(value: String) {
        XCUIApplication().textFields["ExpYear"].tap()
        XCUIApplication().textFields["ExpYear"].clearText()
        XCUIApplication().textFields["ExpYear"].tap()
        XCUIApplication().textFields["ExpYear"].typeText(value)
    }
    
    func typeCVC(value: String) {
        XCUIApplication().textFields["CVC"].tap()
        XCUIApplication().textFields["CVC"].clearText()
        XCUIApplication().textFields["CVC"].tap()
        XCUIApplication().textFields["CVC"].typeText(value)
    }
}
