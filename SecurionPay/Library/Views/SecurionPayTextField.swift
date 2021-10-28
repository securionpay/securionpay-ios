import UIKit

final class SecurionPayTextField: UITextField {
    private let placeholderLabel = UILabel()
    private let permanentPlaceholderLabel = UILabel()
    
    private var animating = false
    private var headerVisible = false
    
    override var text: String? {
        get {
            super.text
        }
        set {
            super.text = newValue
            if let permanentPlaceholder = permanentPlaceholder {
                var suffixLength = permanentPlaceholder.count - (text ?? .empty).count
                if suffixLength < 0 { suffixLength = 0 }
                
                permanentPlaceholderLabel.text = (text ?? .empty) + String(permanentPlaceholder.suffix(suffixLength))
            }
            DispatchQueue.main.async {
                if (newValue ?? .empty).isEmpty && !self.isFirstResponder {
                    self.hideHeader()
                } else {
                    self.showHeader(animated: false)
                }
            }
        }
    }
    
    override var placeholder: String? {
        set {
            placeholderLabel.text = newValue
        }
        get {
            placeholderLabel.text
        }
    }
    
    var permanentPlaceholder: String? {
        didSet {
            var suffixLength = (permanentPlaceholder ?? .empty).count - (text ?? .empty).count
            if suffixLength < 0 { suffixLength = 0 }
            
            permanentPlaceholderLabel.text = (text ?? .empty) + String((permanentPlaceholder ?? .empty).suffix(suffixLength))
            permanentPlaceholderLabel.isHidden = !isFirstResponder || permanentPlaceholder == nil
        }
    }
    var rightImage: UIImage? {
        didSet {
            guard let rightImage = rightImage?.resized(to: CGSize(width: 40, height: 30)) else {
                rightView = nil
                rightViewMode = .never
                return
            }
            DispatchQueue.main.async {
                let imgView = UIImageView(image: rightImage)
                imgView.contentMode = .scaleAspectFit
                imgView.bounds = CGRect(x: 0, y: 0, width: 40, height: 30)
                self.rightView = imgView
                self.rightViewMode = .always
            }
        }
    }
    
    var error: Bool = false {
        didSet {
            if error {
                placeholderLabel.textColor = Style.Color.error
                return
            }
            placeholderLabel.textColor = (text ?? .empty).isEmpty ? Style.Color.gray : Style.Color.primary
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(permanentPlaceholderLabel)
        permanentPlaceholderLabel.font = Style.Font.body
        permanentPlaceholderLabel.textColor = Style.Color.grayLight
        permanentPlaceholderLabel.isHidden = true
        addSubview(placeholderLabel)
        placeholderLabel.font = Style.Font.body
        placeholderLabel.textColor = Style.Color.gray
        font = Style.Font.body
        textColor = Style.Color.gray
    }
    
    override func layoutSubviews() {
        if !animating {
            if !(text ?? .empty).isEmpty || isFirstResponder {
                var new = self.textRect(forBounds: self.bounds)
                new.origin.y = -10
                self.placeholderLabel.frame = new
            } else {
                placeholderLabel.frame = super.textRect(forBounds: self.bounds)
            }
        }
        permanentPlaceholderLabel.frame = textRect(forBounds: bounds)
        self.permanentPlaceholderLabel.isHidden = !isFirstResponder
        super.layoutSubviews()
    }
    
    @discardableResult
    func becomeFirstResponderWithoutAnimation() -> Bool {
        showHeader(animated: false)
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        showHeader(animated: true)
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        if (text ?? .empty).isEmpty {
            hideHeader()
        }
        return super.resignFirstResponder()
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: super.intrinsicContentSize.height+18)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: 0, y: 10, width: bounds.width, height: bounds.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: 0, y: 10, width: bounds.width, height: bounds.height)
    }
    
    private func showHeader(animated: Bool) {
        let animation = {
            var new = self.textRect(forBounds: self.bounds)
            new.origin.y = -10
            self.placeholderLabel.frame = new
            self.placeholderLabel.textColor = Style.Color.primary
            self.placeholderLabel.font = Style.Font.label
            self.permanentPlaceholderLabel.isHidden = false
        }
        
        if animated {
            if animating { return }
            if headerVisible { return }
            headerVisible = true
            animating = true
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    animation()
                } completion: { _ in
                    self.animating = false
                }
            }
        } else {
            animation()
            headerVisible = true
        }
    }
    
    private func hideHeader() {
        if animating { return }
        if !headerVisible { return }
        animating = true
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.placeholderLabel.frame = super.textRect(forBounds: self.bounds)
                self.placeholderLabel.textColor = Style.Color.gray
                self.placeholderLabel.font = Style.Font.body
                self.permanentPlaceholderLabel.isHidden = true
            } completion: { _ in
                self.animating = false
                self.headerVisible = false
            }
        }
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
