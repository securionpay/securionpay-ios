import Foundation

final class CurrencyFormatter {
    static func format(amount: Int, code: String, withSymbol: Bool = true) -> String {
        var amount: Float = Float(amount)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if withSymbol {
            formatter.currencySymbol = code
        } else {
            formatter.currencySymbol = ""
        }
        if let currency = Currency(rawValue: code) {
            if withSymbol {
                formatter.currencySymbol = currency.symbol
            } else {
                formatter.currencySymbol = ""
            }
            amount /= Float(currency.minorUnitsFactor)
        }

        if let formatted = formatter.string(from: NSNumber(value: amount)) {
            return formatted
        }
        if withSymbol {
            return "\(amount) \(code)"
        } else {
            return "\(amount)"
        }
    }
}
