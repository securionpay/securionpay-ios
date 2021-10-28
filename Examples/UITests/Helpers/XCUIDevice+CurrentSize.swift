import XCTest

extension XCUIDevice {
    static func currentDeviceSize(application: XCUIApplication = XCUIApplication()) -> String {
        let frame = application.windows.element(boundBy: 0).frame
        return String(describing: Int(frame.width)) + "x" + String(describing: Int(frame.height))
    }
    
    static var operatingSystemVersion: String {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return String(describing: version.majorVersion) + "." + String(describing: version.minorVersion) + "." + String(describing: version.patchVersion)
    }
}

