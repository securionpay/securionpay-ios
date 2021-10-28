import XCTest

class ThreeDSecureCustomFormTests: BaseTest {
    override func setUp() {
        super.setUp()
        customFormPage = checkoutPage.switchToCustomForm()
        customFormPage.typePublicKey(key: SecurionPayAPI.publicKey)
    }
    
    func testChallengeText() {
        customFormPage.typeCardNumber(value: TestCardNumbers.VisaThreeD.challengeText)
        customFormPage.typeExpMonth(value: "10")
        customFormPage.typeExpYear(value: "2030")
        customFormPage.typeCVC(value: "123")

        threeDPage = customFormPage.payment()
        threeDPage.typeCode(code: "1234")
        customFormPage = threeDPage.submit()
        
        customFormPage.typeCardNumber(value: "")
        let token = SecurionPayAPI().getToken(with: lastSuccededToken!)

        XCTAssertEqual(lastSuccededToken!, token.id)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengeText.prefix(6)), token.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengeText.suffix(4)), token.last4)
        XCTAssertEqual("10", token.expirationMonth)
        XCTAssertEqual("2030", token.expirationYear)
        XCTAssertEqual(10000, token.threeDSecureInfo!.amount)
        XCTAssertEqual("EUR", token.threeDSecureInfo!.currency)
        XCTAssertEqual("successful", token.threeDSecureInfo!.liabilityShift)
    }
    
    func testChallengeTextFailing() {
        customFormPage.typeCardNumber(value: TestCardNumbers.VisaThreeD.challengeText)
        customFormPage.typeExpMonth(value: "10")
        customFormPage.typeExpYear(value: "2030")
        customFormPage.typeCVC(value: "123")

        threeDPage = customFormPage.payment()
        threeDPage.typeCode(code: "1111")
        customFormPage = threeDPage.submit()
        
        customFormPage.typeCardNumber(value: "")
        let token = SecurionPayAPI().getToken(with: lastSuccededToken!)

        XCTAssertEqual(lastSuccededToken!, token.id)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengeText.prefix(6)), token.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengeText.suffix(4)), token.last4)
        XCTAssertEqual("10", token.expirationMonth)
        XCTAssertEqual("2030", token.expirationYear)
        XCTAssertEqual(10000, token.threeDSecureInfo!.amount)
        XCTAssertEqual("EUR", token.threeDSecureInfo!.currency)
        XCTAssertEqual("failed", token.threeDSecureInfo!.liabilityShift)
    }
    
    func testChallenge() {
        customFormPage.typeCardNumber(value: TestCardNumbers.VisaThreeD.challengePassing)
        customFormPage.typeExpMonth(value: "10")
        customFormPage.typeExpYear(value: "2030")
        customFormPage.typeCVC(value: "123")

        threeDPage = customFormPage.payment()
        customFormPage = threeDPage.continue()
        
        customFormPage.typeCardNumber(value: "")
        let token = SecurionPayAPI().getToken(with: lastSuccededToken!)

        XCTAssertEqual(lastSuccededToken!, token.id)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengePassing.prefix(6)), token.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengePassing.suffix(4)), token.last4)
        XCTAssertEqual("10", token.expirationMonth)
        XCTAssertEqual("2030", token.expirationYear)
        XCTAssertEqual(10000, token.threeDSecureInfo!.amount)
        XCTAssertEqual("EUR", token.threeDSecureInfo!.currency)
        XCTAssertEqual("successful", token.threeDSecureInfo!.liabilityShift)
    }
    
    func testChallengeFailing() {
        customFormPage.typeCardNumber(value: TestCardNumbers.VisaThreeD.challengeFailing)
        customFormPage.typeExpMonth(value: "10")
        customFormPage.typeExpYear(value: "2030")
        customFormPage.typeCVC(value: "123")

        threeDPage = customFormPage.payment()
        customFormPage = threeDPage.continue()
        
        customFormPage.typeCardNumber(value: "")
        let token = SecurionPayAPI().getToken(with: lastSuccededToken!)

        XCTAssertEqual(lastSuccededToken!, token.id)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengeFailing.prefix(6)), token.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.challengeFailing.suffix(4)), token.last4)
        XCTAssertEqual("10", token.expirationMonth)
        XCTAssertEqual("2030", token.expirationYear)
        XCTAssertEqual(10000, token.threeDSecureInfo!.amount)
        XCTAssertEqual("EUR", token.threeDSecureInfo!.currency)
        XCTAssertEqual("failed", token.threeDSecureInfo!.liabilityShift)
    }
    
    func testFrictionless() {
        customFormPage.typeCardNumber(value: TestCardNumbers.VisaThreeD.frictionlessPassing2)
        customFormPage.typeExpMonth(value: "10")
        customFormPage.typeExpYear(value: "2030")
        customFormPage.typeCVC(value: "123")

        customFormPage = customFormPage.payment()
        
        customFormPage.typeCardNumber(value: "")
        let token = SecurionPayAPI().getToken(with: lastSuccededToken!)

        XCTAssertEqual(lastSuccededToken!, token.id)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessPassing2.prefix(6)), token.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessPassing2.suffix(4)), token.last4)
        XCTAssertEqual("10", token.expirationMonth)
        XCTAssertEqual("2030", token.expirationYear)
        XCTAssertEqual(10000, token.threeDSecureInfo!.amount)
        XCTAssertEqual("EUR", token.threeDSecureInfo!.currency)
        XCTAssertEqual("successful", token.threeDSecureInfo!.liabilityShift)
    }
    
    func testFrictionlessFailing() {
        customFormPage.typeCardNumber(value: TestCardNumbers.VisaThreeD.frictionlessFailing)
        customFormPage.typeExpMonth(value: "10")
        customFormPage.typeExpYear(value: "2030")
        customFormPage.typeCVC(value: "123")

        customFormPage = customFormPage.payment()
        
        customFormPage.typeCardNumber(value: "")
        let token = SecurionPayAPI().getToken(with: lastSuccededToken!)

        XCTAssertEqual(lastSuccededToken!, token.id)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessFailing.prefix(6)), token.first6)
        XCTAssertEqual(String(TestCardNumbers.VisaThreeD.frictionlessFailing.suffix(4)), token.last4)
        XCTAssertEqual("10", token.expirationMonth)
        XCTAssertEqual("2030", token.expirationYear)
        XCTAssertEqual(10000, token.threeDSecureInfo!.amount)
        XCTAssertEqual("EUR", token.threeDSecureInfo!.currency)
        XCTAssertEqual("failed", token.threeDSecureInfo!.liabilityShift)
    }
    
    func testNotEnrolled() {
        customFormPage.typeCardNumber(value: TestCardNumbers.visa)
        customFormPage.typeExpMonth(value: "10")
        customFormPage.typeExpYear(value: "2030")
        customFormPage.typeCVC(value: "123")

        customFormPage = customFormPage.payment()
        
        customFormPage.typeCardNumber(value: "")
        let token = SecurionPayAPI().getToken(with: lastSuccededToken!)

        XCTAssertEqual(lastSuccededToken!, token.id)
        XCTAssertEqual(String(TestCardNumbers.visa.prefix(6)), token.first6)
        XCTAssertEqual(String(TestCardNumbers.visa.suffix(4)), token.last4)
        XCTAssertEqual("10", token.expirationMonth)
        XCTAssertEqual("2030", token.expirationYear)
        XCTAssertEqual(10000, token.threeDSecureInfo!.amount)
        XCTAssertEqual("EUR", token.threeDSecureInfo!.currency)
        XCTAssertEqual(false, token.threeDSecureInfo!.enrolled)
    }
}
