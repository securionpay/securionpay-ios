import XCTest
import Foundation
@testable import SecurionPay

class CreditCardTests: XCTestCase {
    func testAmericanExpressRecognition() {
        CreditCardNumberGenerator.numbers(for: .americanExpress).forEach {
            let creditCard = CreditCard(number: String($0))
            XCTAssertEqual(CreditCard.CreditCardType.americanExpress, creditCard.type, String($0))
        }
    }
    
    func testDinersClubRecognition() {
        CreditCardNumberGenerator.numbers(for: .diners).forEach {
            let creditCard = CreditCard(number: String($0))
            XCTAssertEqual(CreditCard.CreditCardType.diners, creditCard.type, String($0))
        }
    }
    
    func testDiscoverRecognition() {
        CreditCardNumberGenerator.numbers(for: .discover).forEach {
            let creditCard = CreditCard(number: String($0))
            XCTAssertEqual(CreditCard.CreditCardType.discover, creditCard.type, String($0))
        }
    }
    
    func testJCBRecognition() {
        CreditCardNumberGenerator.numbers(for: .jcb).forEach {
            let creditCard = CreditCard(number: String($0))
            XCTAssertEqual(CreditCard.CreditCardType.jcb, creditCard.type, String($0))
        }
    }
    
    func testMaestroRecognition() {
        CreditCardNumberGenerator.numbers(for: .maestro).forEach {
            let creditCard = CreditCard(number: String($0))
            XCTAssertEqual(CreditCard.CreditCardType.maestro, creditCard.type, String($0))
        }
    }
    
    func testMastercardRecognition() {
        CreditCardNumberGenerator.numbers(for: .mastercard).forEach {
            let creditCard = CreditCard(number: String($0))
            XCTAssertEqual(CreditCard.CreditCardType.mastercard, creditCard.type, String($0))
        }
    }
    
    func testVisaRecognition() {
        CreditCardNumberGenerator.numbers(for: .visa).forEach {
            let creditCard = CreditCard(number: String($0))
            XCTAssertEqual(CreditCard.CreditCardType.visa, creditCard.type, String($0))
        }
    }
    
    func testNumberNumberLength() {
        XCTAssertEqual(15, CreditCard(number: String(TestCardNumbers.amex)).numberLength)
        XCTAssertEqual(14, CreditCard(number: String(TestCardNumbers.diners)).numberLength)
        XCTAssertEqual(16, CreditCard(number: String(TestCardNumbers.discover)).numberLength)
        XCTAssertEqual(16, CreditCard(number: String(TestCardNumbers.jcb)).numberLength)
        XCTAssertEqual(16, CreditCard(number: String(TestCardNumbers.maestro)).numberLength)
        XCTAssertEqual(16, CreditCard(number: String(TestCardNumbers.mastercard)).numberLength)
        XCTAssertEqual(16, CreditCard(number: String(TestCardNumbers.visa)).numberLength)
    }
    
    func testCVCLength() {
        XCTAssertEqual(4, CreditCard(number: String(TestCardNumbers.amex)).cvcLength)
        XCTAssertEqual(3, CreditCard(number: String(TestCardNumbers.diners)).cvcLength)
        XCTAssertEqual(3, CreditCard(number: String(TestCardNumbers.discover)).cvcLength)
        XCTAssertEqual(3, CreditCard(number: String(TestCardNumbers.jcb)).cvcLength)
        XCTAssertEqual(3, CreditCard(number: String(TestCardNumbers.maestro)).cvcLength)
        XCTAssertEqual(3, CreditCard(number: String(TestCardNumbers.mastercard)).cvcLength)
        XCTAssertEqual(3, CreditCard(number: String(TestCardNumbers.visa)).cvcLength)
    }
    
    func testCVCPlaceholder() {
        XCTAssertEqual("0000", CreditCard(number: String(TestCardNumbers.amex)).cvcPlaceholder)
        XCTAssertEqual("000", CreditCard(number: String(TestCardNumbers.diners)).cvcPlaceholder)
        XCTAssertEqual("000", CreditCard(number: String(TestCardNumbers.discover)).cvcPlaceholder)
        XCTAssertEqual("000", CreditCard(number: String(TestCardNumbers.jcb)).cvcPlaceholder)
        XCTAssertEqual("000", CreditCard(number: String(TestCardNumbers.maestro)).cvcPlaceholder)
        XCTAssertEqual("000", CreditCard(number: String(TestCardNumbers.mastercard)).cvcPlaceholder)
        XCTAssertEqual("000", CreditCard(number: String(TestCardNumbers.visa)).cvcPlaceholder)
    }
    
    func testReadable() {
        XCTAssertEqual("3782 822463 10005", CreditCard(number: String(TestCardNumbers.amex)).readable)
        XCTAssertEqual("3056 930902 5904", CreditCard(number: String(TestCardNumbers.diners)).readable)
        XCTAssertEqual("6011 1111 1111 1117", CreditCard(number: String(TestCardNumbers.discover)).readable)
        XCTAssertEqual("3530 1113 3330 0000", CreditCard(number: String(TestCardNumbers.jcb)).readable)
        XCTAssertEqual("6759 6498 2643 8453", CreditCard(number: String(TestCardNumbers.maestro)).readable)
        XCTAssertEqual("5555 5555 5555 4444", CreditCard(number: String(TestCardNumbers.mastercard)).readable)
        XCTAssertEqual("4012 0001 0000 0007", CreditCard(number: String(TestCardNumbers.visa)).readable)
    }
}
