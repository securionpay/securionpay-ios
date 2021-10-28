import XCTest
import Foundation
@testable import SecurionPay

final class CheckoutRequestTests: XCTestCase {
    func testAmount() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 400, currency: "EUR")
        XCTAssertEqual(400, checkoutRequest.amount)
    }
    
    func testCurrency() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 400, currency: "EUR")
        XCTAssertEqual("EUR", checkoutRequest.currency)
    }
    
    func testEuroAmount() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 400, currency: "EUR")
        XCTAssertEqual("€4.00", checkoutRequest.readable)
    }
    
    func testDollarsAmount() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 5412, currency: "USD")
        XCTAssertEqual("$54.12", checkoutRequest.readable)
    }
    
    func testZlotysAmount() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 12345, currency: "PLN")
        XCTAssertEqual("zł 123.45", checkoutRequest.readable)
    }
    
    func testPoundsAmount() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 3954111, currency: "GBP")
        XCTAssertEqual("£39,541.11", checkoutRequest.readable)
    }
    
    func testSwissFrankAmount() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF")
        XCTAssertEqual("CHF 21,113,170.00", checkoutRequest.readable)
    }
    
    func testRememberMeFalse() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF", rememberMe: false)
        XCTAssertFalse(checkoutRequest.rememberMe)
    }
    
    func testRememberMeTrue() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF", rememberMe: true)
        XCTAssertTrue(checkoutRequest.rememberMe)
    }
    
    func test3DSecureIsDisabledByDefault() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF")
        XCTAssertFalse(checkoutRequest.threeDSecure)
    }
    
    func test3DSecureDisabled() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF", threeDS: false)
        XCTAssertFalse(checkoutRequest.threeDSecure)
    }
    
    func test3DSecureEnabled() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF", threeDS: true)
        XCTAssertTrue(checkoutRequest.threeDSecure)
    }
    
    func test3DSecureEnabledRequireEnrolledDisabled() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF", threeDS: true, requireEnrolledCard: false)
        XCTAssertTrue(checkoutRequest.correct)
        XCTAssertFalse(checkoutRequest.requireEnrolledCard)
    }

    func test3DSecureEnabledRequireEnrolledEnabled() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF", threeDS: true, requireEnrolledCard: true)
        XCTAssertTrue(checkoutRequest.correct)
        XCTAssertTrue(checkoutRequest.requireEnrolledCard)
    }

    func test3DSecureEnabledRequireLiabilityDisabled() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF", threeDS: true, requireSuccessfulLiabilityShiftForEnrolledCard: false)
        XCTAssertTrue(checkoutRequest.correct)
        XCTAssertFalse(checkoutRequest.requireSuccessfulLiabilityShiftForEnrolledCard)
    }

    func test3DSecureEnabledRequireLiabilityEnabled() {
        let checkoutRequest = CheckoutRequestGenerator().generate(amount: 2111317122, currency: "CHF", threeDS: true, requireSuccessfulLiabilityShiftForEnrolledCard: true)
        XCTAssertTrue(checkoutRequest.correct)
        XCTAssertTrue(checkoutRequest.requireSuccessfulLiabilityShiftForEnrolledCard)
    }
    
    func testTermsAndConditionsUrl() {
        let url = "https://example.com"
        let checkoutRequest = CheckoutRequestGenerator().generate(termsAndConditionsUrl: url)
        XCTAssertEqual(url, checkoutRequest.termsAndConditions)
    }
    
    func testTermsAndConditionsUrlNilByDefault() {
        let checkoutRequest = CheckoutRequestGenerator().generate()
        XCTAssertNil(checkoutRequest.termsAndConditions)
    }
    
    func testCustomerId() {
        let id = "https://example.com"
        let checkoutRequest = CheckoutRequestGenerator().generate(customerId: id)
        XCTAssertEqual(id, checkoutRequest.customerId)
    }
    
    func testCustomerIdNilByDefault() {
        let checkoutRequest = CheckoutRequestGenerator().generate()
        XCTAssertNil(checkoutRequest.customerId)
    }
    
    func testCrossSaleOffers() {
        let offers = ["1", "2", "3"]
        let checkoutRequest = CheckoutRequestGenerator().generate(crossSaleOfferIds: offers)
        XCTAssertEqual(offers, checkoutRequest.crossSaleOfferIds)
    }
    
    func testCrossSaleOffersNilByDefault() {
        let checkoutRequest = CheckoutRequestGenerator().generate()
        XCTAssertNil(checkoutRequest.crossSaleOfferIds)
    }
    
    func testCorrectRequest() {
        let checkoutRequest = CheckoutRequestGenerator().generate()
        XCTAssertTrue(checkoutRequest.correct)
    }
    
    func testIncorrectRequest() {
        let checkoutRequest = CheckoutRequest(content: "WN1cmUiOnsiZW5hYmxlIjp0cnVlLCJyZXF1aXJlRW5yb2xsZWRDYXJkIjp0cnVlLCJyZXF1aXJlU3VjY2Vzc2Z1bExpYWJpbGl0eVNoaWZ0Rm9yRW5yb2xsZWRDYXJkIjp0cnVlfX0=")
        XCTAssertFalse(checkoutRequest.correct)
    }
    
    func testEmptyPredefiniedDonations() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation(options: [])
        XCTAssertEqual(nil, checkoutRequest.donations)
    }
    
    func testNilPredefinedDonations() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation(options: nil)
        XCTAssertEqual(nil, checkoutRequest.donations)
    }
    
    func testPredefiniedDonations() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation()
        XCTAssertEqual(["€10.00", "€20.00", "€30.00"], checkoutRequest.donations?.map { $0.readable })
    }
    
    func testCustomDonation() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation(options: nil, min: 1000, max: 3000)
        XCTAssertEqual(1000, checkoutRequest.customDonation?.0)
        XCTAssertEqual(3000, checkoutRequest.customDonation?.1)
    }
    
    func testPredefinedAndCustomDonation() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation(options: [1000, 2000, 3000], min: 1000, max: 3000)
        XCTAssertEqual(1000, checkoutRequest.customDonation?.0)
        XCTAssertEqual(3000, checkoutRequest.customDonation?.1)
        XCTAssertEqual(["€10.00", "€20.00", "€30.00"], checkoutRequest.donations?.map { $0.readable })
    }
    
    func testPredefinedAndCustomDonationWithUSD() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation(options: [1000, 2000, 3000], min: 1000, max: 3000, currency: "USD")
        XCTAssertEqual(1000, checkoutRequest.customDonation?.0)
        XCTAssertEqual(3000, checkoutRequest.customDonation?.1)
        XCTAssertEqual(["$10.00", "$20.00", "$30.00"], checkoutRequest.donations?.map { $0.readable })
    }
    
    func testPredefinedAndCustomDonationWithRememberMe() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation(options: [1000, 2000, 3000], min: 1000, max: 3000, rememberMe: true)
        XCTAssertEqual(1000, checkoutRequest.customDonation?.0)
        XCTAssertEqual(3000, checkoutRequest.customDonation?.1)
        XCTAssertEqual(["€10.00", "€20.00", "€30.00"], checkoutRequest.donations?.map { $0.readable })
        XCTAssertTrue(checkoutRequest.rememberMe)
    }
    
    func testDonationRememberMeFalse() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation(rememberMe: false)
        XCTAssertFalse(checkoutRequest.rememberMe)
    }
    
    func testDonationRememberMeTrue() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation(rememberMe: true)
        XCTAssertTrue(checkoutRequest.rememberMe)
    }
    
    func testCheckoutRequestDonationCurrency() {
        let checkoutRequest = CheckoutRequestGenerator().generateDonation()
        XCTAssertEqual("EUR", checkoutRequest.currency)
    }
    
    func testCheckoutRequestWithSubscription() {
        let checkoutRequest = CheckoutRequestGenerator().generateSubscription(planId: "PLAN1")
        XCTAssertEqual("PLAN1", checkoutRequest.subscription?.planId)
        XCTAssertNil(checkoutRequest.donations)
    }
}
    
