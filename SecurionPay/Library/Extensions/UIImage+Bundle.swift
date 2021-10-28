import Foundation
import UIKit

extension Bundle {
    static var securionPay: Bundle {
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return Bundle(for: SecurionPay.self)
        }
        #endif
        
        let url = Bundle(for: SecurionPay.self).url(forResource: "SecurionPayBundle", withExtension: "bundle")!
        return Bundle(url: url)!
    }
}

extension UIImage {
    static func fromBundle(named image: String) -> UIImage? {
        UIImage(named: image, in: Bundle.securionPay, compatibleWith: nil)
    }
}
