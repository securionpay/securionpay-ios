import XCTest
import Foundation

final class Springboard {
    
    static let shared = Springboard()
    
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    let settings = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
    
    /**
     Terminate and delete the app via springboard
     
     */
    private func elementExists(element: XCUIElement, isTapable: Bool = false, waitTime: TimeInterval = 10, file: StaticString = #file, line: Int = #line, function: String = #function) {
        var predicate: NSPredicate!
        if isTapable {
            predicate = NSPredicate(format: "exists == true AND isHittable == true")
        } else {
            predicate = NSPredicate(format: "exists == true")
        }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)

        if XCTWaiter.wait(for: [expectation], timeout: waitTime) != .completed {
            let path = ("\(file)" as NSString).lastPathComponent
            XCTFail("\(path):\(line). Can't find element. (\(element.normalizedDescription()))", file: file, line: UInt(line))
        }
    }
    
    func waitForIcons() {
        let element = springboard.otherElements["Home screen icons"]
        elementExists(element: element, isTapable: false)
    }
    
    func tapAppIcon(name: String) {
        let icon = springboard.otherElements.icons[name]
        icon.tap()
    }
    
    func deleteMyApp(name: String, resetPrivacyAndSettings: Bool = false) {
        XCUIApplication().terminate()
        springboard.activate()
        
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait
        XCUIDevice.shared.press(.home)
        springboard.swipeLeft()
        springboard.swipeLeft()
        springboard.swipeLeft()
        springboard.swipeRight()
        let icon = springboard.otherElements.icons[name].firstMatch
        
        if icon.exists {
            icon.press(forDuration: 1.0)
            tap(element: springboard.buttons["Remove App"].firstMatch, andWaitFor: springboard.buttons["Delete App"].firstMatch)
            tap(element: springboard.buttons["Delete App"].firstMatch, andWaitFor: springboard.alerts.buttons["Delete"].firstMatch)
            springboard.alerts.buttons["Delete"].firstMatch.tap()

            Sleep.miliseconds(100)
            XCUIDevice.shared.press(.home)
            
            guard resetPrivacyAndSettings else { return }
            
            // Handle iOS 11 iPad 'duplication' of icons (one nested under "Home screen icons" and the other nested under "Multitasking Dock"
            let settingsIcon = springboard.otherElements["Home screen icons"].scrollViews.otherElements.icons["Settings"]
            if settingsIcon.exists {
                settingsIcon.tap()
                settings.tables.staticTexts["General"].tap()
                settings.tables.staticTexts["Reset"].tap()
                settings.tables.staticTexts["Reset Location & Privacy"].tap()
                // Handle iOS 11 iPad difference in error button text
                if UIDevice.current.userInterfaceIdiom == .pad {
                    settings.buttons["Reset"].tap()
                } else {
                    settings.buttons["Reset Warnings"].tap()
                }
                settings.terminate()
            }
        }
    }
    
    private func tap(element: XCUIElement, andWaitFor targetElement: XCUIElement, file: StaticString = #file, line: Int = #line) {
        for _ in 1...5 {
            wait(for: element, file: file, line: line)
            element.tap()
            if wait(for: targetElement, assert: false, file: file, line: line) {
                return
            }
        }
    }
    
    @discardableResult
    private func wait(
        for element: XCUIElement,
        hittable: Bool = true,
        assert: Bool = true,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: Int = #line) -> Bool {
        let format = "exists == true"
        let predicate = NSPredicate(format:format + (hittable ? " AND isHittable == true" : ""))
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        if assert && result != .completed {
            let path = ("\(file)" as NSString).lastPathComponent
            XCTFail("\(path):\(line). Can't find element. (\(element.normalizedDescription()))", file: file, line: UInt(line))
        }
        return result == .completed
    }
}


