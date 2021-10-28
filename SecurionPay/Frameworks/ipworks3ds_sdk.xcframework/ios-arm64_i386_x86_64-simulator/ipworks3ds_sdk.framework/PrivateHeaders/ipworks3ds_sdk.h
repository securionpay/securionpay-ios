#import <UIKit/UIKit.h>

//! Project version number for ipworks3ds_sdk.
FOUNDATION_EXPORT double ipworks3ds_sdkVersionNumber;

//! Project version string for ipworks3ds_sdk.
FOUNDATION_EXPORT const unsigned char ipworks3ds_sdkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ipworks3ds_sdk/PublicHeader.h>

#import "IPWorks3DSClient.h"


@interface CgColorToFile: NSObject

+ (void)frameworkDylibIndexSetMinimumDisplaySeconds NS_SWIFT_NAME(frameworkDylibIndexSetMinimumDisplaySeconds());

+ (void)onDataPacketOutSdkAppId: (int) flag NS_SWIFT_NAME(onDataPacketOutSdkAppId(_:));

+ (void)getnameinfoPointee NS_SWIFT_NAME(getnameinfoPointee());

@end