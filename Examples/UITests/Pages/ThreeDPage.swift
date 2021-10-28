import XCTest

final class ThreeDPage: Page {
    var test: BaseTest!
    let pageIdentifier: String? = nil
    
    init() {}
}

extension ThreeDPage {
    func typeCode(code: String) {
        scrollView.textFields.firstMatch.tap()
        Sleep.seconds(1)
        scrollView.textFields.firstMatch.typeText(code)
    }
    
    func submit<T: Page>() -> T {
        scrollView.buttons["Submit"].tap()
        Sleep.seconds(10)
        return T(test: test)
    }
    
    func `continue`<T: Page>() -> T {
        scrollView.buttons["Continue"].tap()
        Sleep.seconds(10)
        return T(test: test)
    }
    
    func cancel<T: Page>() -> T {
        return T(test: test)
    }
    
    private var scrollView: XCUIElementQuery { XCUIApplication().scrollViews.containing(.staticText, identifier: "3D-Secure test mode authentication") }
}
