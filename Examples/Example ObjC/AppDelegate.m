#import "AppDelegate.h"
@import SecurionPay;

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SecurionPay.shared.publicKey = @"pk_test_5Es53HxsxAlE4Cy43dzs3ZR4";
    
    return YES;
}

@end
