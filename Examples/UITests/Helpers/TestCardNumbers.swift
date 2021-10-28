import Foundation

enum TestCardNumbers {
    enum ValidationError {
        static let invalidNumber = "4024007102349866"
        static let invalidExpiryMonth = "4532873294814636"
        static let invalidExpiryYear = "4532582477951947"
        static let invalidCVC = "4024007189368227"
        static let expiredCard = "4916487051294548"
        
        static let all = [invalidNumber, invalidExpiryMonth, invalidExpiryYear, invalidCVC, expiredCard]
    }
    
    enum ProcessingError {
        static let incorrectCVC = "4024007134364842"
        static let insufficientFunds = "4024007118468684"
        static let lostOrStolen = "4024007114621187"
        static let suspectedFraud = "4024007155502486"
        static let cardDeclined = "4916018475814056"
        static let authenticationRequired = "4916449457024978"
        static let processingError = "4024007114166316"
        
        static let all = [insufficientFunds, lostOrStolen, cardDeclined]
    }
    
    enum VisaThreeD {
        static let frictionlessPassing = "4012000100000114"
        static let frictionlessPassing2 = "4012000200000113"
        static let frictionlessPassing3 = "4012000300000112"
        static let frictionlessFailing = "4012000700000118"
        static let challengePassing = "4012001700000017"
        static let challengeFailing = "40120010300001112"
        static let challengeText = "4016000000000004"
        static let challengeSingleSelect = "4016000000000012"
        static let challengeMultiSelect = "4016000000000020"
        static let challengeHTML = "4016000000000038"
    }
    
    static let visa = "4012000100000007"
    static let mastercard = "5555555555554444"
    static let maestro = "6759649826438453"
    static let amex = "378282246310005"
    static let discover = "6011111111111117"
    static let diners = "30569309025904"
    static let jcb = "3530111333300000"
    
    static let all = [visa, mastercard, maestro, amex, discover, diners, jcb]
}
