import XCTest

protocol Page {
    var test: BaseTest! { get set }
    var pageIdentifier: String? { get }

    init()
    init(test: BaseTest, waitForView: Bool, file: StaticString, line: Int)
}

extension Page {
    init(test: BaseTest, waitForView: Bool = true, file: StaticString = #file, line: Int = #line) {
        self.init()
        self.test = test
        checkViewsVisibility(waitForView: waitForView, file: file, line: line)
    }

    func checkViewsVisibility(waitForView: Bool, file: StaticString = #file, line: Int = #line) {
        guard let pageIdentifier = pageIdentifier else {
            XCTContext.runActivity(named: "Opening page: " + String(describing: self)) { _ in }
            return
        }
        _ = XCTContext.runActivity(named: "Opening page: " + String(describing: self)) { _ in
            self.test.other(with: pageIdentifier, wait: waitForView, file: file, line: line)
        }
    }
    
    func recursiveDescription() -> String {
        ""
//        self.test.other(with: pageIdentifier, wait: true).snapshotDescription
    }
    
    func tap(
        element: XCUIElement,
        wait: Bool = true,
        file: StaticString = #file,
        line: Int = #line) {
        if (wait) {
            self.wait(for: element, file: file, line: line)
        }
        if element.isHittable {
            element.tap()
        } else {
            XCTFail("Can't hit element. (\(element.normalizedDescription()))", file: file, line: UInt(line))
        }
    }
    
    func tap(element: XCUIElement, andWaitFor targetElement: XCUIElement, file: StaticString = #file, line: Int = #line) {
        for _ in 1...5 {
            wait(for: element, file: file, line: line)
            element.tap()
            if wait(for: targetElement, assert: false, file: file, line: line) {
                return
            }
        }
    }
    
    @discardableResult func wait(
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
    
    func rotate(to orientation: UIDeviceOrientation) {
        XCUIDevice.shared.orientation = orientation
    }
}

