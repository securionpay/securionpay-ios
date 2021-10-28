import Foundation
import UIKit

struct CreditCard {
    enum CreditCardType: String {
        case visa
        case maestro
        case mastercard
        case americanExpress
        case discover
        case diners
        case jcb

        case unknown
    }
    
    let type: CreditCardType
    let number: String?
    let last2: String?
    let last4: String?
    
    static var empty = CreditCard(number: "")
    
    init(number: String? = .empty) {
        self.type = CreditCardType(number: number)
        self.number = number
        self.last2 = nil
        self.last4 = nil
    }
    
    init(card: Card) {
        self.type = CreditCardType(rawValue: card.brand) ?? .unknown
        self.number = nil
        self.last2 = card.last2
        self.last4 = card.last4
    }
    
    var image: UIImage? {
        switch type {
        case .visa: return UIImage.fromBundle(named: "visa")
        case .mastercard: return UIImage.fromBundle(named: "mastercard")
        case .americanExpress: return UIImage.fromBundle(named: "amex")
        case .discover: return UIImage.fromBundle(named: "discover")
        case .unknown: return UIImage.fromBundle(named: "unknown")
        case .diners: return UIImage.fromBundle(named: "diners")
        case .jcb: return UIImage.fromBundle(named: "jcb")
        case .maestro: return UIImage.fromBundle(named: "maestro")
        }
    }
    
    var background: (String, String) {
        switch type {
        case .visa: return ("#3749af", "#26337a")
        case .mastercard: return ("#000099", "#000066")
        case .americanExpress: return ("008dff", "0072ce")
        case .discover: return ("eb945b", "e6772f")
        case .unknown: return ("#b9bcc1", "#8c969c")
        case .diners: return ("beb2a1", "9a8666")
        case .jcb: return ("1550a7", "12438c")
        case .maestro: return ("000099", "000066")
        }
    }
    
    var numberLength: Int {
        switch type {
        case .americanExpress: return 15
        case .diners: return 14
        default: return 16
        }
    }
    
    var cvcLength: Int {
        type == .americanExpress ? 4 : 3
    }
    
    var cvcPlaceholder: String {
        type == .americanExpress ? "0000" : "000"
    }
    
    var correct: Bool {
        var sum = 0
        let digitStrings = cardNumber.reversed().map { String($0) }

        for tuple in digitStrings.enumerated() {
            if let digit = Int(tuple.element) {
                let odd = tuple.offset % 2 == 1

                switch (odd, digit) {
                case (true, 9):
                    sum += 9
                case (true, 0...8):
                    sum += (digit * 2) % 9
                default:
                    sum += digit
                }
            } else {
                return false
            }
        }
        return sum % 10 == 0
    }
    
    var readable: String {
        var result = ""
        var currentCharacterIndex = 0
        var patternIndex = 0
        let array = Array(cardNumber.sanitized()).prefix(numberLength)
        
        for index in 0..<array.count {
            result.append(array[index])
            currentCharacterIndex += 1
            if separationPattern[patternIndex] == currentCharacterIndex {
                patternIndex += 1
                currentCharacterIndex = 0
                if patternIndex < separationPattern.count {
                    result.append(" ")
                }
            }
        }
        
        if result.last == " " {
            result.removeLast()
        }
        return result
    }
    
    var numberOfSpaces: Int {
        readable.filter { $0 == " " }.count
    }
    
    private var cardNumber: String {
        if let number = number {
            return number
        } else if let last2 = last2 {
            return String(repeating: "•", count: numberLength-2) + last2
        } else if let last4 = last4 {
            return String(repeating: "•", count: numberLength-4) + last4
        } else {
            return String(repeating: "•", count: numberLength)
        }
    }
    
    
    private var separationPattern: [Int] {
        switch type {
        case .americanExpress: return [4, 6, 5]
        case .diners: return [4, 6, 4]
        default: return [4, 4, 4, 4]
        }
    }
}

extension CreditCard.CreditCardType: CaseIterable {}

extension CreditCard.CreditCardType {
    init(number: String?) {
        guard let number = number else { self = .unknown; return }
        self = CreditCard.CreditCardType.cardTypeForCreditCardNumber(cardNumber: number) ?? .unknown
    }
}

extension CreditCard.CreditCardType {
    private struct Card {
        static let unknown = Card(type: .unknown, prefix: 0...0, patterns: [])
        
        let type: CreditCard.CreditCardType
        let prefix: ClosedRange<Int>
        let patterns: [ClosedRange<Int>]
    }
    
    private func validationRegex() -> Card {
        switch self {
        case .visa: return Card(type: .visa, prefix: 1...1, patterns: [4...4])
        case .mastercard: return Card(type: .mastercard, prefix: 2...4, patterns: [51...55, 2221...2720])
        case .americanExpress: return Card(type: .americanExpress, prefix: 2...2, patterns: [34...34, 37...37])
        case .discover: return Card(type: .discover, prefix: 2...2, patterns: [60...60, 64...65])
        case .unknown: return .unknown
        case .diners: return Card(type: .diners, prefix: 2...3, patterns: [300...305, 309...309, 36...36, 38...39])
        case .jcb: return Card(type: .jcb, prefix: 4...4, patterns: [2131...2131, 1800...1800, 3528...3689])
        case .maestro: return Card(type: .maestro, prefix: 2...2, patterns: [67...67])
        }
    }
    
    private static func cardTypeForCreditCardNumber(cardNumber: String) -> CreditCard.CreditCardType? {
        for card in CreditCard.CreditCardType.allCases {
            for prefixRangeElement in card.validationRegex().prefix {
                guard let prefix = Int(cardNumber.sanitized().prefix(prefixRangeElement)) else { return .unknown }
                for pattern in card.validationRegex().patterns {
                    if pattern.contains(prefix) {
                        return card
                    }
                }
            }
        }
        return .unknown
    }
}

extension CreditCard: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.type == rhs.type && lhs.number == lhs.number
    }
}
