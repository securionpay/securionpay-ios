Pod::Spec.new do |s|
  s.name          = "SecurionPay"
  s.version       = "1.0.0"
  s.summary       = "iOS SDK for SecurionPay"
  s.description   = "iOS SDK for SecurionPay"
  s.homepage      = "https://securionpay.com/"
  s.license       = "MIT"
  s.author        = "securionpay"
  s.platform      = :ios, "12.0"
  s.swift_version = "4.2"
  s.source        = {
    :git => "https://github.com/securionpay/securionpay-ios.git",
    :tag => "#{s.version}"
  }
  s.source_files        = "SecurionPay/Library/**/*.{h,m,swift}"
  s.vendored_frameworks = "SecurionPay/Frameworks/ipworks3ds_sdk.xcframework"
  s.subspec 'Resources' do |resources|
   resources.resource_bundle = {'SecurionPayBundle' => ['SecurionPay/**/*.{strings}', 'SecurionPay/**/*.{png}', 'SecurionPay/**/*.{ttf}']}
 end
end
