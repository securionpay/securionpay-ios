#import <Foundation/Foundation.h>
@import XCTest;
@import SecurionPay;
#import "UnitTests-Swift.h"

@interface ObjCIntegrationSmokeTests: XCTestCase
@property (nonatomic, retain) XCTestExpectation* testExpectation;
@end

@implementation ObjCIntegrationSmokeTests

- (void)setUp {
    [super setUp];
    SecurionPay.shared.publicKey = SecurionPayAPI.publicKey;
    self.testExpectation = [self expectationWithDescription:@"Token"];
}

- (void)testCreatingToken {
    SPTokenRequest* tokenRequest = [[SPTokenRequest alloc]
                                    initWithNumber:TestCardNumbersObjC.visa
                                    expirationMonth:@"10"
                                    expirationYear:@"2050"
                                    cvc:@"123"
                                    cardholder:nil];
    [SecurionPay.shared createTokenWith:tokenRequest completion:^(SPToken *result, SPError *error) {
        XCTAssertNotNil(result);
        XCTAssertNil(error);
        [self.testExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:20 handler:nil];
}

- (void)testAuthenticateFrictionlessPassing {
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] initWithNibName:nil bundle:nil]];
    SPTokenRequest* tokenRequest = [[SPTokenRequest alloc]
                                    initWithNumber:TestCardNumbersObjC.frictionlessPassing
                                    expirationMonth:@"10"
                                    expirationYear:@"2050"
                                    cvc:@"123"
                                    cardholder:nil];
    [SecurionPay.shared createTokenWith:tokenRequest completion:^(SPToken *result, SPError *error) {
        XCTAssertNotNil(result);
        XCTAssertNil(error);
        [SecurionPay.shared authenticateWithToken:result amount:10000 currency:@"EUR" navigationControllerFor3DS:navController completion:^(SPToken *authenticatedToken, SPError *authenticationError) {
            XCTAssertNil(authenticationError);
            XCTAssertTrue(authenticatedToken.threeDSecureInfo.enrolled);
            XCTAssertEqual(SPLiabilityShiftSuccessful, authenticatedToken.threeDSecureInfo.liabilityShift);
            XCTAssertNil(authenticationError);
            [self.testExpectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:25 handler:nil];
}

- (void)testAuthenticateFrictionlessFailing {
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] initWithNibName:nil bundle:nil]];
    SPTokenRequest* tokenRequest = [[SPTokenRequest alloc]
                                    initWithNumber:TestCardNumbersObjC.frictionlessFailing
                                    expirationMonth:@"10"
                                    expirationYear:@"2050"
                                    cvc:@"123"
                                    cardholder:nil];
    [SecurionPay.shared createTokenWith:tokenRequest completion:^(SPToken *result, SPError *error) {
        XCTAssertNotNil(result);
        XCTAssertNil(error);
        [SecurionPay.shared authenticateWithToken:result amount:10000 currency:@"EUR" navigationControllerFor3DS:navController completion:^(SPToken *authenticatedToken, SPError *authenticationError) {
            XCTAssertNil(authenticationError);
            XCTAssertTrue(authenticatedToken.threeDSecureInfo.enrolled);
            XCTAssertEqual(SPLiabilityShiftFailed, authenticatedToken.threeDSecureInfo.liabilityShift);
            XCTAssertNil(authenticationError);
            [self.testExpectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:25 handler:nil];
}

@end
