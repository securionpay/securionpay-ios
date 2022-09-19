import UIKit
import SecurionPay

final class CheckoutViewController: UIViewController {
    @IBOutlet weak var publicKey: UITextField!
    @IBOutlet weak var checkoutRequest: UITextField!
    
    @IBAction func didTapPaymentButton(_ sender: Any) {
        SecurionPay.shared.publicKey = publicKey.text
        SecurionPay.shared.bundleIdentifier = "com.securionpay.sdk.SecurionPay.Examples"
        SecurionPay.shared.showCheckoutViewController(
            in: self,
            checkoutRequest: CheckoutRequest(content: checkoutRequest.text!)) { [weak self] result, error in
                if let result = result {
                    let alert = UIAlertController(title: "Payment succeeded!", message: "Charge id: \(result.chargeId ?? "-")\nSubscription id: \(result.subscriptionId ?? "-")", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                } else if let error = error {
                    let alert = UIAlertController(title: "Error!", message: error.localizedMessage(), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Payment cancelled!", message: "Try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
    }
    
    @IBAction func didTapClearCardsButton(_ sender: Any) {
        SecurionPay.shared.publicKey = publicKey.text
        SecurionPay.shared.cleanSavedCards()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "CheckoutViewController"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
