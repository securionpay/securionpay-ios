import XCTest

extension XCTest {
    func elementExists(element: XCUIElement, isTapable: Bool = false, waitTime: TimeInterval = 10, file: StaticString = #file, line: Int = #line, function: String = #function) {
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
    
    @discardableResult
    func other(with identifier: String, wait: Bool = false, file: StaticString = #file, line: Int = #line) -> XCUIElement {
        let element = XCUIApplication().otherElements.element(matching: .any, identifier: identifier).firstMatch
        if wait {
            elementExists(element: element, isTapable: false, file: file, line: line)
        }
        return element
    }
    
    func button(with identifier: String, isTapable: Bool = true, wait: Bool = false, file: StaticString = #file, line: Int = #line) -> XCUIElement {
        let element = XCUIApplication().buttons[identifier].firstMatch
        if wait {
            elementExists(element: element, isTapable: isTapable, file: file, line: line)
        }
        return element
    }
    
    func label(with identifier: String, isTapable: Bool = true, wait: Bool = false, firstMatch: Bool = true, file: StaticString = #file, line: Int = #line) -> XCUIElement {
        var element: XCUIElement!
        if firstMatch {
            element = XCUIApplication().staticTexts[identifier].firstMatch
        } else {
            element = XCUIApplication().staticTexts[identifier]
        }
        if wait {
            elementExists(element: element, isTapable: isTapable, file: file, line: line)
        }
        return element
    }
    
    func textField(with identifier: String, isTapable: Bool = true, wait: Bool = false, file: StaticString = #file, line: Int = #line) -> XCUIElement {
        let element = XCUIApplication().textFields[identifier].firstMatch
        if wait {
            elementExists(element: element, isTapable: isTapable, file: file, line: line)
        }
        return element
    }
}

