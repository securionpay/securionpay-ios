import Foundation

final class Keychain {
    static var lastEmail: String? {
        get { UserDefaults.standard.string(forKey: "____SECURIONPAY_SDK_LAST_EMAIL") }
        set { UserDefaults.standard.set(newValue, forKey: "____SECURIONPAY_SDK_LAST_EMAIL") }
    }
    
    static func cleanSavedEmails() {
        Keychain.lastEmail = nil
    }
}
