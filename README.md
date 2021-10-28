![](https://securionpay.com/wp-content/uploads/2017/11/logo_v_rich.png)	

# SecurionPay iOS SDK

Welcome to SecurionPay iOS SDK. Framework makes it easy to add SecurionPay payments to your mobile apps. It allows you to integrate SecurionPay with just a few lines of code. It also provides customizable UI elements and exposes low-level SecurionPay API from which you can create a custom payment form.

## Features

#### Security

All sensitive data is sent directly to our servers instead of using your backend, so you can be sure that your payments are highly secure.

#### 3D-Secure

Add a smart 3D Secure verification with superior UX to your transactions. Provide smooth and uninterrupted payment experience that doesn’t interfere with your conversion process.

#### SecurionPay API

We provide methods corresponding to SecurionPay API. It allows you creating an entirely custom UI embedded into your application to increase conversion by keeping clients inside your app.

#### Translations

You can process payments in 18 languages.

## Installation

### CocoaPods

Because of issues related with XCFramework, you have to use version **1.10.1** of CocoaPods or higher.

Use the following entry in your Podfile:

```ruby
pod 'SecurionPay', '~> 1.0.0'
```

Then run `pod install`.

Do not forget to import the framework with `import SecurionPay` or with `@import SecurionPay;` for Objectove-C projects at the beginning of any file you'd like to use SecurionPay in.

## Usage

If you have not created an account yet, you can do it here: https://securionpay.com/signup.

### Configuration

To configure the framework you need to provide the public key. You can find it here: https://securionpay.com/account-settings. Notice that there are two types of keys: live and test. The type of key determines application mode. Make sure you used a live key in build released to App Store.

#### Swift

```swift
SecurionPay.shared.publicKey = "pk_test_..."
```

#### Objective-C

```objective-c
SecurionPay.shared.publicKey = @"pk_test_...";
```

### Checkout View Controller

Checkout View Controller is an out-of-box solution designed to provide the smoothest payment experience possible. It is a simple overlay with payments that appears on top of your page. Well-designed and ready to use. 

To present Checkout View Controller you need to create Checkout Request on your backend side. You can find more informations about Checkout Requests here: https://securionpay.com/docs/api#checkout-request. You can also create test Checkout Request here: https://securionpay.com/docs/checkout-request-generator.

#### Swift

```swift
let checkoutRequest = ...
SecurionPay.shared.showCheckoutViewController(
    in: self,
    checkoutRequest: checkoutRequest) { [weak self] result, error in
        if let result = result {
            print(result.subscriptionId)
            print(result.chargeId)
        } else if let error = error {
            print(error.localizedMessage())
        } else {
            // cancelled
        }
    }
```

#### Objective-C

```objective-c
SPCheckoutRequest* checkoutRequest = ...;
[[SecurionPay shared] showCheckoutViewControllerIn:self
                                       checkoutRequest:checkoutRequest
                                            completion:^(SPPaymentResult * result, SPError * error) {
    if (result != nil) {
        NSLog(@"%@", result.subscriptionId);
        NSLog(@"%@", result.chargeId);
    } else if (error != nil) {
        NSLog(@"%@", [error localizedMessage]);
    } else {
        // Cancelled
    }
}];
```

### Custom Form

#### Swift

```swift
let request = TokenRequest(
    number: "4242424242424242",
    expirationMonth: "10",
    expirationYear: "2023",
    cvc: "123"
)

SecurionPay.shared.createToken(with: request) { token, error in
    guard let self = self else { return }
    guard let navController = self.navigationController else { return }
    guard let token = token else { print(error); return }
            
    SecurionPay.shared.authenticate(token: token, amount: 10000, currency: "EUR", navigationControllerFor3DS: navController) { [weak self] authenticatedToken, authenticationError in
        print(authenticatedToken)      
        print(authenticationError)                                                                                                     
    }
}
```

## Testing

When making requests in test mode you have to use special card numbers to simulate successful charges or processing errors. You can find list of card numbers here: https://securionpay.com/docs/testing. You can check status of every charge you made here: https://securionpay.com/charges.

Remember not to make too many requests in a short period of time or you may reach a rate limit. If you reach the limit you have to wait 24h.

## Translations

SDK supports localization for 18 languages. Your application must be localized.

## License

Framework is released under the MIT Licence.