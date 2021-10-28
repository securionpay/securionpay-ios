import Foundation
import UIKit

protocol SMSCodeTextFieldDelegate: class {
    func didEnterCode(code: String)
}

final class SMSCodeTextField: UIView {
    private let textField = UITextField()
    private let stack = UIStackView()
    private let fields = [UIView(), UIView(), UIView(), UIView(), UIView(), UIView()]
    
    weak var delegate: SMSCodeTextFieldDelegate?
    var code: String { textField.text ?? .empty }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func clear() {
        textField.text = nil
        updateFields(forceFirst: true)
    }
    
    func error() {
        textField.text = nil
        fields.forEach { $0.layer.borderColor = Style.Color.error.cgColor }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.updateFields()
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        textField.text = nil
        DispatchQueue.main.async {
            self.updateFields(forceFirst: true)
        }
        return textField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        DispatchQueue.main.async {
            self.clearFields()
        }
        return textField.resignFirstResponder()
    }
    
    private func commonInit() {
        fields.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addConstraints([
                $0.heightAnchor.constraint(equalToConstant: 48),
                $0.widthAnchor.constraint(equalToConstant: 48)
            ])
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.red.cgColor
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        addConstraints([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.widthAnchor.constraint(equalToConstant: 308)
        ])
        stack.axis = .horizontal
        stack.spacing = 4.0
        fields.forEach { stack.addArrangedSubview($0) }

        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        addConstraints([
            textField.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 18),
            textField.rightAnchor.constraint(equalTo: stack.rightAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 48)
        ])
        textField.delegate = self
        textField.tintColor = .white
        textField.clearsOnBeginEditing = true
        textField.defaultTextAttributes = [
            NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .bold),
            NSAttributedString.Key.foregroundColor: Style.Color.primary,
            NSAttributedString.Key.kern: 36
        ]
        textField.keyboardType = .numberPad
    }
    
    private func updateFields(forceFirst: Bool = false) {
        clearFields()
        if forceFirst {
            fields.first?.layer.borderColor = Style.Color.primary.cgColor
        }
        if textField.isFirstResponder {
            let index = (textField.text ?? .empty).count
            if index < fields.count {
                fields[index].layer.borderColor = Style.Color.primary.cgColor
            }
        }
    }
    
    private func clearFields() {
        fields.forEach { $0.layer.borderColor = Style.Color.grayLight.cgColor }
    }
}

extension SMSCodeTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        guard let textRange = Range(range, in: text) else { return true }
        
        let updatedText = String(text.replacingCharacters(in: textRange, with: string).prefix(6))
        textField.text = updatedText
        if updatedText.count == 6 {
            delegate?.didEnterCode(code: updatedText)
        }
        updateFields()
        return false
    }
}
