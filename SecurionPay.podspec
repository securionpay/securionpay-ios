Pod::Spec.new do |s|
  s.name          = "SecurionPay"
  s.version       = "1.0.16"
  s.summary       = "iOS SDK for SecurionPay"
  s.description   = "Framework makes it easy to add SecurionPay payments to your mobile apps."
  s.homepage      = "https://github.com/securionpay/securionpay-ios.git"
  s.license       = "MIT"
  s.author        = "securionpay"
  s.platform      = :ios, "13.0"
  s.swift_version = "4.2"
  s.source        = {
    :git => "https://github.com/securionpay/securionpay-ios.git",
    :tag => "#{s.version}"
  }
  s.vendored_frameworks = "SecurionPay.xcframework"
end
