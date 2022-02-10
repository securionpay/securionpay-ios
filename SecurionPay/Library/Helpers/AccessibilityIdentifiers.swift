import Foundation

enum AccessibilityIdentifier {
    enum PaymentViewController {
        static let identifier = "AccessibilityIdentifier.PaymentViewController.identifier"
        static let titleLabel = "AccessibilityIdentifier.PaymentViewController.titleLabel"
        static let email = "AccessibilityIdentifier.PaymentViewController.email"
        static let cardNumber = "AccessibilityIdentifier.PaymentViewController.cardNumber"
        static let expiration = "AccessibilityIdentifier.PaymentViewController.expiration"
        static let cvc = "AccessibilityIdentifier.PaymentViewController.cvc"
        static let sms = "AccessibilityIdentifier.PaymentViewController.sms"
        static let button = "AccessibilityIdentifier.PaymentViewController.button"
        static let closeButton = "AccessibilityIdentifier.PaymentViewController.closeButton"
        static let rememberSwitch = "AccessibilityIdentifier.PaymentViewController.rememberSwitch"
        static let emailErrorLabel = "AccessibilityIdentifier.PaymentViewController.emailErrorLabel"
        static let cardErrorLabel = "AccessibilityIdentifier.PaymentViewController.cardErrorLabel"
        static let errorLabel = "AccessibilityIdentifier.PaymentViewController.errorLabel"
        static func donationCell(with title: String) -> String {
            "AccessibilityIdentifier.PaymentViewController.DonationCarousel." + title
        }
    }
}
