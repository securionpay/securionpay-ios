import Foundation

final class ExpirationDateFormatter {
    struct Result {
        let text: String?
        let placeholder: String?
        let resignFocus: Bool
    }
    
    static func format(inputText: String, backspace: Bool) -> Result {
        var updatedExpiration: String
        var placeholder: String?
        var resignFocus = false
        
        placeholder = "MM/YY"
        
        let components = inputText.components(separatedBy: "/").filter { !$0.isEmpty }
        if components.count == 2 {
            if components[0].count >= 3 {
                if Int(components[0].prefix(1)) ?? 0 <= 1 {
                    return Result(text: String(components[0].prefix(1)), placeholder: placeholder, resignFocus: false)
                } else {
                    return Result(text: "0" + components[0].prefix(1) + "/", placeholder: placeholder, resignFocus: false)
                }
            }
            let first = components[0].prefix(2)
            if first.count == 1 {
                if Int(first) == 0 {
                    return Result(text: "0", placeholder: placeholder, resignFocus: false)
                } else {
                    return Result(text: "0" + first + "/" + components[1], placeholder: placeholder, resignFocus: false)
                }
            } else if components[1].first ?? "0" == "0" {
                let number = Int(first) ?? 0
                if number <= 1 {
                    return Result(text: String(number), placeholder: placeholder, resignFocus: false)
                }
                else if number < 10 || number >= 20{
                    return Result(text: "0" + String(first.prefix(1)) + "/", placeholder: placeholder, resignFocus: false)
                } else if number <= 12 {
                    return Result(text: String(first.prefix(2)) + "/", placeholder: placeholder, resignFocus: false)
                } else if number < 20 {
                    return Result(text: "1", placeholder: placeholder, resignFocus: false)
                }
            }
        }
        
        
        updatedExpiration = inputText.replacingOccurrences(of: "/", with: "")
        if updatedExpiration.count == 1 {
            if (Int(updatedExpiration) ?? 0) > 1 {
                updatedExpiration = "0\(updatedExpiration)/"
            }
        } else if updatedExpiration.count == 2 {
            if (Int(updatedExpiration) ?? 0) == 0 {
                updatedExpiration = "0"
            } else if (Int(updatedExpiration) ?? 0) > 12 {
                updatedExpiration = "1"
            } else if !backspace {
                updatedExpiration.insert("/", at: updatedExpiration.index(updatedExpiration.startIndex, offsetBy: 2))
            }
        } else if updatedExpiration.count > 2 {
            updatedExpiration.insert("/", at: updatedExpiration.index(updatedExpiration.startIndex, offsetBy: 2))
            let components = updatedExpiration.components(separatedBy: "/")
            if let lastString = components.last, let year = Int(lastString),
               components.count == 2 {
                if year <= 1 {
                    updatedExpiration.removeLast()
                } else if year == 20 {
                    placeholder = "MM/YYYY"
                } else if year > 100 && year < 1000 && (year < 202 || year > 210) {
                    updatedExpiration.removeLast()
                    placeholder = "MM/YY"
                } else if year > 1000 && year < 2021 {
                    updatedExpiration.removeLast()
                    placeholder = "MM/YYYY"
                }
                if year > 20 && year < 100 && updatedExpiration.count >= 5 {
                    resignFocus = true
                }
                if year == 20 || (year >= 202 && year <= 209) {
                    placeholder = "MM/YYYY"
                }
            }
        }
        
        if updatedExpiration.count >= 7 {
            resignFocus = true
            placeholder = "MM/YYYY"
            updatedExpiration = String(updatedExpiration.prefix(7))
        }
        
        return Result(text: updatedExpiration, placeholder: placeholder, resignFocus: resignFocus)
    }
}
