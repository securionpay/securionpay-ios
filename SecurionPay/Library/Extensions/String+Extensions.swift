import Foundation
import UIKit

extension String {
    static var empty: String { "" }
        
    func sanitized() -> String {
        self
            .replacingOccurrences(of: " ", with: "")
            .trimmingCharacters(in: CharacterSet(charactersIn: "0123456789•").inverted)
    }
    
    static func localized(_ key: String, value: String? = nil) -> String {
        Bundle.securionPay.localizedString(forKey: key, value: value, table: nil)
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        Data(self.utf8).base64EncodedString()
    }
}
