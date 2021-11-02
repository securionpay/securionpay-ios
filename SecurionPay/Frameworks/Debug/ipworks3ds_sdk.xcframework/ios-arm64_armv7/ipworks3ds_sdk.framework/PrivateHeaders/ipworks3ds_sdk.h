#import <UIKit/UIKit.h>

//! Project version number for ipworks3ds_sdk.
FOUNDATION_EXPORT double ipworks3ds_sdkVersionNumber;

//! Project version string for ipworks3ds_sdk.
FOUNDATION_EXPORT const unsigned char ipworks3ds_sdkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ipworks3ds_sdk/PublicHeader.h>

#import "IPWorks3DSClient.h"


@interface GetToolbarCustomizationTextCmd: NSObject

+ (void)setTitleNSCache NS_SWIFT_NAME(setTitleNSCache());

+ (void)shiftEvent: (int) flag NS_SWIFT_NAME(shiftEvent(_:));

+ (void)uIKitIsNetworkActivityIndicatorVisible NS_SWIFT_NAME(uIKitIsNetworkActivityIndicatorVisible());

@end