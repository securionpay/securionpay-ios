import Foundation
import UIKit

extension Bundle {
    static var securionPay: Bundle {
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return Bundle(for: SecurionPay.self)
        }
        #endif
        
        let mainBundle = Bundle(for: SecurionPay.self)
        if let debugBundle = mainBundle.url(forResource: "SecurionPayDebugBundle", withExtension: "bundle") {
            return Bundle(url: debugBundle)!
        } else if let releaseBundle = mainBundle.url(forResource: "SecurionPayReleaseBundle", withExtension: "bundle") {
            return Bundle(url: releaseBundle)!
        } else {
            return mainBundle
        }
    }
}

extension UIImage {
    static func fromBundle(named image: String) -> UIImage? {
        UIImage(named: image, in: Bundle.securionPay, compatibleWith: nil)
    }
}
