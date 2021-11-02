import UIKit

final class SecurionPayButton: UIView {
    enum State {
        case normal
        case pending
        case finished
    }
    enum ButtonStyle {
        case primary
        case secondary
    }
    private let button = UIButton()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let checkmark = UIImageView(image: UIImage.fromBundle(named: "checkmark"))
    private let imageView = UIImageView()
    
    private var buttonLeftAnchor: NSLayoutConstraint?
    private var buttonRightAnchor: NSLayoutConstraint?
    
    var title: String? {
        set { button.setTitle(newValue, for: .normal) }
        get { button.title(for: .normal) }
    }
    
    var image: UIImage? {
        set {
            imageView.image = newValue
            if !button.isEnabled {
                imageView.alpha = 0.5
            }
        }
        get { imageView.image }
    }
    
    var style: ButtonStyle = .primary {
        didSet {
            updateStyle()
        }
    }
    
    var didTap: (()->Void)?
    
    var enabled: Bool {
        set {
            button.isEnabled = newValue
            imageView.alpha = newValue ? 1 : 0.5
        }
        get { button.isEnabled }
    }
    
    override var accessibilityIdentifier: String? {
        set { button.accessibilityIdentifier = newValue }
        get { button.accessibilityIdentifier }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func changeState(to state: State, animated: Bool = true) {
        switch state {
        case .normal:
            self.buttonLeftAnchor?.constant = 0
            self.buttonRightAnchor?.constant = 0
            let transform = {
                self.layoutIfNeeded()
                self.button.layer.cornerRadius = Style.Layout.cornerRadius
                self.button.titleLabel?.alpha = 1
                self.activityIndicator.alpha = 0
                self.button.backgroundColor = Style.Color.primary
                self.checkmark.alpha = 0
                self.checkmark.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.imageView.alpha = 1
            }
            if animated {
                UIView.animate(withDuration: 0.1) { transform() }
            } else {
                DispatchQueue.main.async { transform () }
            }
            updateStyle()
        case .pending:
            let constant = (self.bounds.width - self.bounds.height)/2
            self.buttonLeftAnchor?.constant = constant
            self.buttonRightAnchor?.constant = -constant
            let transform = {
                self.layoutIfNeeded()
                self.button.layer.cornerRadius = self.bounds.height/2
                self.button.titleLabel?.alpha = 0
                self.activityIndicator.alpha = 1
                self.activityIndicator.color = .white
                self.button.backgroundColor = Style.Color.primary
                self.checkmark.alpha = 0
                self.checkmark.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.imageView.alpha = 0
            }
            if animated {
                UIView.animate(withDuration: 0.1) { transform() }
            } else {
                DispatchQueue.main.async { transform () }
            }
        case .finished:
            let constant = (self.bounds.width - self.bounds.height)/2
            self.buttonLeftAnchor?.constant = constant
            self.buttonRightAnchor?.constant = -constant
            let transform = {
                self.layoutIfNeeded()
                self.button.layer.cornerRadius = self.bounds.height/2
                self.button.titleLabel?.alpha = 0
                self.activityIndicator.alpha = 0
                self.button.backgroundColor = Style.Color.success
                self.checkmark.alpha = 1
                self.checkmark.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.imageView.alpha = 0
            }
            if animated {
                UIView.animate(withDuration: 0.1) { transform() }
            } else {
                DispatchQueue.main.async { transform () }
            }
        }
    }

    private func commonInit() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        buttonLeftAnchor = button.leftAnchor.constraint(equalTo: leftAnchor)
        buttonRightAnchor = button.rightAnchor.constraint(equalTo: rightAnchor)
        
        addConstraints([
            button.topAnchor.constraint(equalTo: topAnchor),
            buttonLeftAnchor!,
            buttonRightAnchor!,
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        addConstraints([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.startAnimating()
        activityIndicator.alpha = 0
        activityIndicator.color = .white
        
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkmark)
        addConstraints([
            checkmark.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkmark.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        checkmark.alpha = 0
        checkmark.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.layer.cornerRadius = Style.Layout.cornerRadius
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addConstraints([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
        
        updateStyle()
    }
    
    private func updateStyle() {
        switch style {
        case .primary:
            button.backgroundColor = Style.Color.primary
            button.titleLabel?.font = Style.Font.button
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
            button.layer.borderWidth = 0
        case .secondary:
            button.backgroundColor = .white
            button.titleLabel?.font = Style.Font.button
            button.setTitleColor(Style.Color.primary, for: .normal)
            button.setTitleColor(Style.Color.primary.withAlphaComponent(0.5), for: .disabled)
            button.layer.borderWidth = 1
            button.layer.borderColor = Style.Color.primary.cgColor
        }
    }
    
    @objc private func didTapButton() {
        didTap?()
    }
}
