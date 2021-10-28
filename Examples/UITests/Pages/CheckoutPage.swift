import XCTest

final class CheckoutPage: Page {
    var test: BaseTest!
    let pageIdentifier: String? = "CheckoutViewController"
    
    init() {}
}

extension CheckoutPage {
    func switchToCustomForm<T: Page>() -> T {
        XCUIApplication().buttons["Custom Form"].tap()
        return T(test: test)
    }
    
    func typePublicKey(key: String) {
        UIPasteboard.general.string = key
        XCUIApplication().textFields["PublicKey"].press(forDuration: 1)
        XCUIApplication().textFields["PublicKey"].press(forDuration: 1)
        let menuQuery = XCUIApplication().menuItems
        let menuItem = menuQuery["Paste"]
        _ = menuItem.waitForExistence(timeout: 5)
        menuItem.tap()
        Sleep.miliseconds(500)
    }
    
    func typeCheckoutRequest(request: String) {
        UIPasteboard.general.string = request
        XCUIApplication().textFields["CheckoutRequest"].press(forDuration: 1)
        XCUIApplication().textFields["CheckoutRequest"].press(forDuration: 1)
        let menuQuery = XCUIApplication().menuItems
        let menuItem = menuQuery["Paste"]
        _ = menuItem.waitForExistence(timeout: 5)
        menuItem.tap()
        Sleep.miliseconds(500)
    }
    
    func payment<T: Page>() -> T{
        XCUIApplication().buttons["Payment"].tap()
        Sleep.seconds(1)
        return T(test: test)
    }
    
    func clearSavedCards() {
        XCUIApplication().buttons["Clear saved cards"].tap()
    }
}
