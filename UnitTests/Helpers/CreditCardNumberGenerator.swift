import Foundation
@testable import SecurionPay

final class CreditCardNumberGenerator {
    static func numbers(for type: CreditCard.CreditCardType) -> [Int] {
        Array(repeating: {0}, count: 10000).map { _ in number(for: type) }
    }
    
    static func number(for type: CreditCard.CreditCardType) -> Int {
        /* Obtain proper card length */
        var cardLength = 16
        cardLength = (type == .americanExpress) ? 15 : cardLength
        cardLength = (type == .diners) ? 14 : cardLength
        
        var cardNumber = [Int](repeating: 0, count: cardLength)
        var startingIndex = 0
        
        /* Conform to rules for beginning card numbers */
        if type == .visa {
            cardNumber[0] = 4
            startingIndex = 1
        }
        else if type == .mastercard {
            cardNumber[0] = 5
            cardNumber[1] = Int(arc4random_uniform(5) + 1)
            startingIndex = 2
        }
        else if type == .discover {
            cardNumber.replaceSubrange(Range(0...3), with: [6,0,1,1])
            startingIndex = 4
        }
        else if type == .americanExpress{
            cardNumber.replaceSubrange(Range(0...1), with: [3,4])
            startingIndex = 2
        }
        else if type == .diners {
            cardNumber.replaceSubrange(Range(0...1), with: [3,6])
            startingIndex = 2
        }
        else if type == .jcb {
            cardNumber.replaceSubrange(Range(0...3), with: [3,5,2,8])
            startingIndex = 4
        } else if type == .maestro {
            cardNumber[0] = 6
            cardNumber[1] = 7
            startingIndex = 2
        }
        
        
        /* Fill array with random numbers 0-9 */
        for i in startingIndex..<cardNumber.count{
            cardNumber[i] = Int(arc4random_uniform(10))
        }
        
        /* Calculate the final digit using a custom variation of Luhn's formula
           This way we dont have to spend time reversing the array
         */
        let offset = (cardNumber.count+1)%2
        var sum = 0
        for i in 0..<cardNumber.count-1 {
            if ((i+offset) % 2) == 1 {
                var temp = cardNumber[i] * 2
                if temp > 9{
                    temp -= 9
                }
                sum += temp
            }
            else{
                sum += cardNumber[i]
            }
        }
        let finalDigit = (10 - (sum % 10)) % 10
        cardNumber[cardNumber.count-1] = finalDigit
        
        //Convert cardnumber array to string
        return Int(cardNumber.map({ String($0) }).joined(separator: ""))!
    }
}

