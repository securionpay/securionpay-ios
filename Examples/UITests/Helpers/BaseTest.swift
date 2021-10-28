import XCTest

class BaseTest: XCTestCase {
    var app = XCUIApplication()
    var checkoutPage: CheckoutPage!
    var customFormPage: CustomFormPage!
    var page: PaymentViewControllerPage!
    var threeDPage: ThreeDPage!

    var fastlaneShapshotTarget = false
    var reinstallAppBeforeRun = true
    var registerUserBeforeRun = true
    var allowNotificationsDirectly = false
    var documents: [String] = []
    
    var lastSuccededCharge: String?
    var lastSuccededToken: String?
    var lastSuccededSubscription: String?
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        if reinstallAppBeforeRun {
            reinstallApp()
        } else {
            app.launchArguments = launchArguments
            app.launch()
        }
        
        addUIInterruptionMonitor(withDescription: "Alerts") {
            (alert) -> Bool in
            self.lastSuccededCharge = alert.staticTexts.allElementsBoundByIndex
                .compactMap { $0.label }
                .first { $0.prefix(11) == "Charge id: " }?
                .replacingOccurrences(of: " Subscription id: -", with: "")
                .replacingOccurrences(of: "Charge id: ", with: "")
                .components(separatedBy: " ")
                .first
            self.lastSuccededToken = alert.staticTexts.allElementsBoundByIndex
                .compactMap { $0.label }
                .first { $0.prefix(10) == "Token id: " }?
                .replacingOccurrences(of: "Token id: ", with: "")
            self.lastSuccededSubscription = alert.staticTexts.allElementsBoundByIndex
                .compactMap { $0.label }
                .first { $0.prefix(11) == "Charge id: " }?
                .replacingOccurrences(of: " Subscription id: -", with: "")
                .replacingOccurrences(of: "Charge id: ", with: "")
                .components(separatedBy: " ")
                .last
            let allowButton = alert.buttons["OK"]
            if allowButton.exists {
                allowButton.tap()
                return true
            } else {
                return false
            }
        }

        checkoutPage = CheckoutPage(test: self)
    }
    
    override func tearDown() {
        lastSuccededCharge = nil
        let testFailed = testRun?.failureCount ?? 1 > 0
        super.tearDown()
    }
    
    func restartApp(
        enterPin: Bool = false,
        airplaneMode: Bool = false,
        tunnel: Bool = false,
        biometricsEnabled: Bool = true,
        authenticateUsingBiometrics: Bool = true) {
        let activityName: String = "Restarting app. " +
            (enterPin ? "Enter Pin " : "") +
            (airplaneMode ? "Airplane Mode " : "") +
            (tunnel ? "Tunnel " : "") +
            (biometricsEnabled ? "Biometrics enabled " : "") +
            (authenticateUsingBiometrics ? "Authenticate Using Biometrics" : "")
        XCTContext.runActivity(named: activityName) { _ in
            app.terminate()
            app.launchArguments = launchArguments
            app.launch()
        }
    }
    
    func startAirplaneMode() {
        XCTContext.runActivity(named: "Starting airplane mode. All requests will result with error.") { _ in

        }
    }
    
    func stopAirplaneMode() {
        XCTContext.runActivity(named: "Stopping airplane mode") { _ in

        }
    }
    
    func reinstallApp(login: Bool = false, tunnel: Bool = false, biometrics: Bool = true) {
        XCTContext.runActivity(named: "Restart application") { _ in
            deleteApp()
            app = XCUIApplication()
            app.launchArguments = launchArguments
            app.launch()
        }
    }
    
    func deleteApp() {
        Springboard.shared.deleteMyApp(name: "Example")
    }
    
    func goToBackground(for seconds: UInt32 = 0, andReturn: Bool = true) {
        XCTContext.runActivity(named: "Going to background for \(seconds) seconds.") { _ in
            XCUIDevice.shared.press(.home)
            Springboard.shared.waitForIcons()
            Sleep.seconds(seconds)
        }

        if andReturn {
            XCTContext.runActivity(named: "Returning from background after \(seconds) seconds.") { _ in
                Springboard.shared.tapAppIcon(name: "Sigia")
            }
        }
    }
    
    func returnFromBackground() {
        XCTContext.runActivity(named: "Returning from background.") { _ in
            Springboard.shared.tapAppIcon(name: "Sigia")
        }
    }
    
    func terminateApp() {
        XCTContext.runActivity(named: "Terminating application") { _ in
            app.terminate()
        }
    }
    
    private var launchArguments: [String] {
        var result = [LaunchArguments.isUITest.rawValue]
        if !documents.isEmpty {
            result.append("-" + LaunchArguments.documents.rawValue)
            result.append(documents
                .compactMap { Bundle(for: Self.self).url(forResource: $0, withExtension: nil) }
                .map { $0.absoluteString }
                .joined(separator: ",")
            )
        }
        return result
    }
}

