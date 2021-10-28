import Foundation

final class Keychain {
    static var lastEmail: String? {
        get { UserDefaults.standard.string(forKey: "LAST") }
        set {
            UserDefaults.standard.set(newValue, forKey: "LAST")
            addSavedEmail(newValue)
        }
    }
    
    static func isEmailSaved(email: String?) -> Bool {
        guard let email = email?.lowercased() else { return false }
        return emails.contains(email)
    }
    
    static func cleanSavedEmails() {
        Keychain.lastEmail = nil
        Keychain.emails = []
    }
    
    private static var emails: [String] {
        get { UserDefaults.standard.array(forKey: "SAVED_EMAILS") as? [String] ?? [] }
        set { UserDefaults.standard.setValue(newValue, forKey: "SAVED_EMAILS") }
    }
    
    private static func addSavedEmail(_ email: String?) {
        guard let email = email?.lowercased() else { return }
        var set = Set<String>()
        emails.forEach { set.insert($0) }
        set.insert(email)
        UserDefaults.standard.setValue(Array(set), forKey: "SAVED_EMAILS")
    }
}
