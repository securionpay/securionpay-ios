import Foundation
import UIKit

final class CheckoutViewController: UIViewController {
    private enum Constants {
        static let errorAnimationDuration = 0.3
        static let switchModeAnimationDuration = 0.2
        static let preAnimationAlpha: CGFloat = 0.4
        static let postAnimationAlpha: CGFloat = 1.0
    }
    enum Mode {
        case donation
        case newCard
        case sms
        case getCheckoutDetails
    }
    
    private let close = UIButton(type: .custom)
    private let header = UIView()
    private let scroll = UIScrollView()
    private let stack = UIStackView()
    private let topSeparator = UIView()
    private let titleLabel = UILabel()
    private let cardNumber = SecurionPayTextField()
    private let email = SecurionPayTextField()
    private let expiration = SecurionPayTextField()
    private let cvc = SecurionPayTextField()
    private let error = UILabel()
    private let additionalInfo = UILabel()
    private let rememberSwitch = SecurionPaySwitch()
    private let buttonSeparator = UIView()
    private let button = SecurionPayButton()
    private let bottomSeparator = UIView()
    private let emailInfoLabel = UILabel()
    private let emailContainer = UIStackView()
    private let emailError = UILabel()
    private let cardContainerLabel = UILabel()
    private let cardError = UILabel()
    private let horizontalStack = UIStackView()
    private let separator = UIView()
    private let cardContainer = UIStackView()
    private let donationCarousel = DonationCarousel()
    
    private let spinnerSection = SpinnerSection()
    private let smsInfo = UILabel()
    private let smsInfoTitle = UILabel()
    private let smsInfoImage = UIImageView(image: UIImage.fromBundle(named: "locker_dark"))
    private let smsCode = SMSCodeTextField()
    
    private var scrollBottomAnchor: NSLayoutConstraint?
    private var scrollEqualToStackAnchor: NSLayoutConstraint?
    private var scrollHeightAnchor: NSLayoutConstraint?
    private var bottomSeparatorHeightConstraint: NSLayoutConstraint?
    private var processing = false
    private var currentCard = CreditCard.empty
    private var mode: Mode
    private var stackTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGesture))
    
    private let checkoutRequest: CheckoutRequest
    private let completion: (PaymentResult?, SecurionPayError?) -> Void
    
    private var savedEmail: String?
    private var lastSMS: SMS?
    private var phoneVerified = false
    private var donation: Donation?
    private var subscription: CompleteSubscription?
    private let haptic = UINotificationFeedbackGenerator()
    private var keyboardVisible = false
    private let checkoutManager = CheckoutManager()
    
    init(checkoutRequest: CheckoutRequest, completion: @escaping (PaymentResult?, SecurionPayError?) -> Void) {
        self.checkoutRequest = checkoutRequest
        self.completion = completion
        if checkoutRequest.customDonation != nil || checkoutRequest.donations != nil {
            self.mode = .donation
        } else if checkoutRequest.subscription != nil {
            self.mode = .getCheckoutDetails
        } else {
            self.mode = .newCard
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get { .portrait }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        if mode == .newCard {
            if Keychain.lastEmail == nil {
                email.becomeFirstResponderWithoutAnimation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        setupLayout()
        registerForNotifications()
        setupAccessibilityIdentifiers()
        setNewCardSectionVisible(mode == .newCard)
        setSMSSectionVisible(mode == .sms)
        setDonationSectionVisible(mode == .donation)
        
        switch mode {
        case .getCheckoutDetails:
            getCheckoutData()
            break
        case .donation:
            button.image = nil
            button.title = .localized("confirm")
            titleLabel.text = .localized("select_amount")
            donationCarousel.donations = checkoutRequest.donations ?? []
        case .newCard:
            titleLabel.text = .localized("add_payment")
            stackTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGesture))
            stack.addGestureRecognizer(stackTapGestureRecognizer)
            button.enabled = false
            cardError.isHidden = true
            updateButtonStatus()
            lookupIfNeeded()
        case .sms:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if keyboardVisible {
            bottomSeparatorHeightConstraint?.constant = Style.Layout.Padding.medium
        } else {
            bottomSeparatorHeightConstraint?.constant = view.safeAreaInsets.bottom
        }
    }
    
    private func getCheckoutData() {
        showSpinner(hideButton: true)
        checkoutManager.checkoutRequestDetails(checkoutRequest: checkoutRequest) { details, error in
            if let details = details {
                self.subscription = details.subscription
                self.hideSpinner()
                self.switchMode(to: .newCard)
                self.lookupIfNeeded()
            } else {
                DispatchQueue.main.async {
                    self.completion(nil, .unknown)
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func showSpinner(hideButton: Bool) {
        setRememberSwitchActiveMode(mode: false)
        setTextFieldsEnabled(false, withEmail: false)
        hideErrors()
        
        emailInfoLabel.isHidden = true
        emailContainer.isHidden = true
        cardContainerLabel.isHidden = true
        cardContainer.isHidden = true
        rememberSwitch.isHidden = true
        spinnerSection.isHidden = false
        
        if hideButton {
            button.isHidden = true
        }
    }
    
    private func hideSpinner() {
        setRememberSwitchActiveMode(mode: true)
        setTextFieldsEnabled(true, withEmail: true)
        hideErrors()
        
        emailInfoLabel.isHidden = false
        emailContainer.isHidden = false
        cardContainerLabel.isHidden = false
        cardContainer.isHidden = false
        rememberSwitch.isHidden = false
        spinnerSection.isHidden = true
        button.isHidden = false
    }
    
    private func lookupIfNeeded() {
        if let lastEmail = Keychain.lastEmail {
            email.text = lastEmail
            lookup()
        }
    }
    
    private func lookup() {
        guard let email = email.text else { return }
        guard Keychain.isEmailSaved(email: email) else {
            setRememberSwitchActiveMode(mode: true)
            if savedEmail != nil {
                currentCard = CreditCard()
                savedEmail = nil
                cardNumber.text = nil
                expiration.text = nil
                cvc.text = nil
                cardNumber.rightImage = currentCard.image
            }
            return
        }
        
        showSpinner(hideButton: false)
        
        checkoutManager.lookup(email: email) { [weak self] lookupResult, error in
            guard let self = self else { return }
            self.button.changeState(to: .normal)
            self.email.text = email
            if let lookupResult = lookupResult {
                if let phone = lookupResult.phone {
                    self.checkoutManager.sendSMS(email: email) { [weak self] sms, error in
                        guard let self = self else { return }
                        self.setTextFieldsEnabled(true)
                        if let sms = sms {
                            self.switchMode(to: .sms, animated: false)
                            self.lastSMS = sms
                            self.savedEmail = email
                            self.phoneVerified = phone.verified
                        } else if let error = error {
                            self.showError(error: error)
                        } else {
                            self.showError(error: .unknown)
                        }
                    }
                } else {
                    self.emailInfoLabel.isHidden = false
                    self.emailContainer.isHidden = false
                    self.cardContainerLabel.isHidden = false
                    self.cardContainer.isHidden = false
                    self.rememberSwitch.isHidden = false
                    self.spinnerSection.isHidden = true
                    self.currentCard = CreditCard(card: lookupResult.card)
                    self.cardNumber.text = self.currentCard.readable
                    self.expiration.text = "••/••"
                    self.savedEmail = email
                    self.email.text = email
                    self.cardNumber.rightImage = self.currentCard.image
                    self.setTextFieldsEnabled(true)
                    self.setRememberSwitchActiveMode(mode: false)
                    self.cvc.becomeFirstResponderWithoutAnimation()
                    self.updateButtonStatus()
                }
            } else {
                self.emailInfoLabel.isHidden = false
                self.emailContainer.isHidden = false
                self.cardContainerLabel.isHidden = false
                self.cardContainer.isHidden = false
                self.rememberSwitch.isHidden = false
                self.spinnerSection.isHidden = true
                self.currentCard = .empty
                self.cardNumber.text = self.currentCard.readable
                self.expiration.text = nil
                self.savedEmail = email
                self.email.text = email
                self.cardNumber.rightImage = self.currentCard.image
                self.setTextFieldsEnabled(true)
                self.setRememberSwitchActiveMode(mode: true)
                self.email.becomeFirstResponderWithoutAnimation()
                self.updateButtonStatus()
            }
        }
    }
    
    @objc private func didTapGesture() {
        view.endEditing(true)
    }
    
    @objc private func didTapCloseButton() {
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            self.completion(nil, nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func processPaymentResult(result: PaymentResult?, error: SecurionPayError?) {
        if let error = error {
            if error.code ?? .unknown == .verificationCodeRequired {
                self.lookup()
                return
            }
            self.button.changeState(to: .normal)
            self.processing = false
            self.setTextFieldsEnabled(true)
            if self.mode == .newCard {
                if error.type == .cardError, let code = error.code {
                    switch code {
                    case .invalidNumber, .invalidExpiryMonth, .invalidExpiryYear, .invalidCVC, .incorrectCVC, .expiredCard, .cardDeclined, .lostOrStolen:
                        self.haptic.notificationOccurred(.warning)
                        UIView.animate(withDuration: Constants.errorAnimationDuration) {
                            self.cardError.isHidden = false
                            self.cardError.text = error.localizedMessage()
                            self.cardContainer.layer.borderColor = Style.Color.error.cgColor
                            self.stack.setCustomSpacing(4, after: self.cardContainer)
                        }
                    default:
                        self.showError(error: error)
                    }
                } else if error.code == .invalidEmail {
                    self.haptic.notificationOccurred(.warning)
                    UIView.animate(withDuration: Constants.errorAnimationDuration) {
                        self.email.error = true
                        self.emailError.isHidden = false
                        self.emailError.text = error.localizedMessage().replacingOccurrences(of: "email: ", with: "")
                        self.emailContainer.layer.borderColor = Style.Color.error.cgColor
                        self.stack.setCustomSpacing(4, after: self.emailContainer)
                    }
                } else if error.type == .threeDSecure {
                    DispatchQueue.main.async {
                        self.completion(result, error)
                    }
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showError(error: error)
                }
            } else {
                if error.type == .threeDSecure {
                    DispatchQueue.main.async {
                        self.completion(result, error)
                    }
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showError(error: error)
                }
            }
        } else if let result = result {
            self.button.changeState(to: .finished)
            self.haptic.notificationOccurred(.success)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                DispatchQueue.main.async {
                    self.completion(result, nil)
                }
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            self.processing = false
            self.setTextFieldsEnabled(true)
            self.button.changeState(to: .normal)
        }
    }
    
    private func showError(error: SecurionPayError) {
        haptic.notificationOccurred(.error)
        UIView.animate(withDuration: Constants.errorAnimationDuration) {
            self.stack.setCustomSpacing(16, after: self.buttonSeparator)
            self.error.isHidden = false
            self.error.text = error.localizedMessage()
        }
    }
    
    private func didTapButton() {
        if mode == .donation {
            donation = donationCarousel.current
            switchMode(to: .newCard)
            return
        }
        
        if mode == .sms {
            switchMode(to: .newCard)
            setRememberSwitchActiveMode(mode: true)
            rememberSwitch.isOn = checkoutRequest.rememberMe
            return
        }
        
        guard !processing else { return }
        processing = true
        
        hideErrors()
        setTextFieldsEnabled(false)
        
        let components = expiration.text!.components(separatedBy: "/")
        let tokenRequest = TokenRequest(
            number: cardNumber.text!,
            expirationMonth: components.first!,
            expirationYear: components.last!,
            cvc: cvc.text!
        )
        button.changeState(to: .pending)
        
        if let savedEmail = savedEmail {
            checkoutManager.savedToken(email: savedEmail) { [weak self] token, error in
                guard let self = self else { return }
                
                if let token = token {
                    self.checkoutManager.pay(
                        token: token,
                        checkoutRequest: self.checkoutRequest,
                        email: savedEmail,
                        remember: true,
                        cvc: self.cvc.text!,
                        sms: self.lastSMS,
                        amount: self.donation?.amount ?? self.subscription?.plan.amount,
                        currency: self.donation?.currency ?? self.subscription?.plan.currency,
                        navigationControllerFor3DS: self.navigationController!
                    ) { [weak self] result, error in
                        self?.processPaymentResult(result: result, error: error)
                    }
                } else if let _ = error {
                    self.showError(error: .unknown)
                    self.setTextFieldsEnabled(true)
                    self.button.changeState(to: .normal)
                } else {
                    self.setTextFieldsEnabled(true)
                    self.button.changeState(to: .normal)
                }
            }
            return
        }
        checkoutManager.pay(
            tokenRequest: tokenRequest,
            checkoutRequest: checkoutRequest,
            email: email.text!,
            remember: rememberSwitch.isOn,
            amount: donation?.amount ?? subscription?.plan.amount,
            currency: donation?.currency ?? subscription?.plan.currency,
            navigationControllerFor3DS: self.navigationController!
        ) { [weak self] result, error in
            guard let self = self else { return }
            if let _ = result, self.rememberSwitch.isOn {
                Keychain.lastEmail = self.email.text
            }
            self.processPaymentResult(result: result, error: error)
        }
    }
    
    private func verifySMS() {
        let code = smsCode.code
        guard code.count == 6 else { return }
        guard let lastSMS = lastSMS else { return }
        
        checkoutManager.verifySMS(code: code, sms: lastSMS) { [weak self] response, error in
            guard let self = self else { return }
            if let card = response?.card {
                self.currentCard = CreditCard(card: card)
                self.cardNumber.text = self.currentCard.readable
                self.cardNumber.rightImage = self.currentCard.image
                self.setRememberSwitchActiveMode(mode: false)
                self.processing = false
                if self.phoneVerified {
                    self.expiration.text = "••/••"
                    self.cvc.text = "•••"
                } else {
                    self.expiration.text = "••/••"
                    self.cvc.text = nil
                }
                self.switchMode(to: .newCard)
                self.updateButtonStatus()
            } else if let error = error {
                if error.code != .invalidVerificationCode {
                    self.showError(error: error)
                }
                self.smsCode.error()
            } else {
                self.showError(error: .unknown)
                self.smsCode.error()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func switchMode(to mode: Mode, animated: Bool = true) {
        self.mode = mode
        switch mode {
        case .donation, .getCheckoutDetails:
            break
        case .newCard:
            setNewCardSectionAlpha(Constants.preAnimationAlpha)
            button.style = .primary
            button.image = UIImage.fromBundle(named: "locker")
            if let donation = donation {
                button.title = "\(String.localized("pay")) \(donation.readable)"
            } else if let subscription = subscription {
                button.title = "\(String.localized("pay")) \(subscription.readable)"
            } else {
                button.title = "\(String.localized("pay")) \(checkoutRequest.readable)"
            }
            hideSpinner()
        case .sms:
            spinnerSection.isHidden = true
            setSMSSectionAlpha(Constants.preAnimationAlpha)
            button.style = .secondary
            button.title = .localized("enter_card_details")
            additionalInfo.text = .localized("no_code_info")
        }
        updateButtonStatus()
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: animated ? Constants.switchModeAnimationDuration : 0) {
            self.hideErrors()
            self.emailContainer.layer.borderColor = Style.Color.grayLight.cgColor
            self.cardContainer.layer.borderColor = Style.Color.grayLight.cgColor
            self.updateStack()
        } completion: { _ in
            if self.mode == .sms {
                _ = self.smsCode.becomeFirstResponder()
            }
        }
    }
    
    private func updateStack() {
        stack.setCustomSpacing(32, after: buttonSeparator)
        
        setNewCardSectionVisible(mode == .newCard)
        setSMSSectionVisible(mode == .sms)
        setDonationSectionVisible(mode == .donation)
        setNewCardSectionAlpha(mode == .newCard ? Constants.postAnimationAlpha : 0.0)
        setSMSSectionAlpha(mode == .sms ? Constants.postAnimationAlpha : 0.0)
        
        switch mode {
        case .getCheckoutDetails:
            break
        case .donation:
            titleLabel.text = .localized("select_amount")
        case .newCard:
            titleLabel.text = .localized("add_payment")
            stackTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGesture))
            stack.addGestureRecognizer(stackTapGestureRecognizer)
            self.stack.setCustomSpacing(32, after: self.emailContainer)
            self.stack.setCustomSpacing(16, after: self.cardContainer)
            if (email.text ?? .empty).isEmpty {
                email.becomeFirstResponderWithoutAnimation()
            } else if (cardNumber.text ?? .empty).isEmpty {
                cardNumber.becomeFirstResponderWithoutAnimation()
            } else if (cvc.text ?? .empty).isEmpty {
                cvc.becomeFirstResponderWithoutAnimation()
            } else {
                view.endEditing(true)
            }
            updateButtonStatus()
            setRememberSwitchActiveMode(mode: savedEmail == nil)
        case .sms:
            titleLabel.text = .localized("add_payment")
            view.endEditing(true)
            smsCode.clear()
            stack.removeGestureRecognizer(stackTapGestureRecognizer)
            updateButtonStatus()
        }
    }
    
    private func setTextFieldsEnabled(_ enabled: Bool, withEmail: Bool = true) {
        if withEmail {
            email.isEnabled = enabled
        }
        cardNumber.isEnabled = enabled
        expiration.isEnabled = enabled
        cvc.isEnabled = enabled
        rememberSwitch.isEnabled = enabled
        close.isEnabled = enabled
    }
    
    private func setNewCardSectionAlpha(_ alpha: CGFloat) {
        emailInfoLabel.alpha = alpha
        emailContainer.alpha = alpha
        cardContainerLabel.alpha = alpha
        cardContainer.alpha = alpha
        rememberSwitch.alpha = alpha
        buttonSeparator.alpha = alpha
    }
    
    private func setSMSSectionAlpha(_ alpha: CGFloat) {
        smsInfo.alpha = alpha
        smsCode.alpha = alpha
        smsInfo.alpha = alpha
        smsCode.alpha = alpha
        additionalInfo.alpha = alpha
    }
    
    private func setNewCardSectionVisible(_ visible: Bool) {
        emailInfoLabel.isHidden = !visible
        emailContainer.isHidden = !visible
        cardContainerLabel.isHidden = !visible
        cardContainer.isHidden = !visible
        rememberSwitch.isHidden = !visible
        buttonSeparator.isHidden = !visible
    }
    
    private func setSMSSectionVisible(_ visible: Bool) {
        smsInfoImage.isHidden = !visible
        smsInfoTitle.isHidden = !visible
        smsInfo.isHidden = !visible
        smsCode.isHidden = !visible
        additionalInfo.isHidden = !visible
    }
    
    private func setDonationSectionVisible(_ visible: Bool) {
        donationCarousel.isHidden = !visible
    }
    
    private func setRememberSwitchActiveMode(mode: Bool) {
        rememberSwitch.title = .localized("save_for_future_payments")
        if mode {
            rememberSwitch.isHidden = false
            additionalInfo.text = nil
            //            additionalInfo.isHidden = true
            stack.setCustomSpacing(16, after: cardContainer)
        } else {
            rememberSwitch.isHidden = true
            stack.setCustomSpacing(32, after: cardContainer)
            //            additionalInfo.isHidden = false
            additionalInfo.text = .localized("securion_remembers")
        }
    }
}

extension CheckoutViewController {
    private func setupLayout() {
        setupScroll()
        setupHeader()
        setupCloseButton()
        setupTitleLabel()
        setupTopSeparator()
        setupDonationCarousel()
        setupCardSection()
        spinnerSection.isHidden = true
        setupSMSSection()
        setupAdditionalInfoLabel()
        setupErrorLabel()
        setupButton()
        setupStack()
    }
    
    private func setupScroll() {
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        view.addSubview(scroll)
        scrollBottomAnchor = scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        view.addConstraints([
            scroll.leftAnchor.constraint(equalTo: view.leftAnchor),
            scroll.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollBottomAnchor!
        ])
    }
    
    private func setupHeader() {
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .white
        view.addSubview(header)
        view.addConstraints([
            header.heightAnchor.constraint(equalToConstant: 48.0 + Style.Layout.Padding.big),
            header.leftAnchor.constraint(equalTo: view.leftAnchor),
            header.rightAnchor.constraint(equalTo: view.rightAnchor),
            header.bottomAnchor.constraint(equalTo: scroll.topAnchor)
        ])
        header.layer.cornerRadius = 10
        header.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupCloseButton() {
        close.translatesAutoresizingMaskIntoConstraints = false
        close.setImage(UIImage.fromBundle(named: "close"), for: .normal)
        close.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        header.addSubview(close)
        header.addConstraints([
            close.heightAnchor.constraint(equalToConstant: 88),
            close.widthAnchor.constraint(equalToConstant: 70),
            close.topAnchor.constraint(equalTo: header.topAnchor, constant: -10),
            close.rightAnchor.constraint(equalTo: header.rightAnchor,constant: 0)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(titleLabel)
        header.addConstraints([
            titleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: Style.Layout.Padding.big),
            titleLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: Style.Layout.Padding.standard),
            titleLabel.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -Style.Layout.Padding.standard)
        ])
        titleLabel.font = Style.Font.title
        titleLabel.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.titleLabel
        titleLabel.textColor = .black
    }
    
    private func setupTopSeparator() {
        topSeparator.backgroundColor = .white
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        topSeparator.addConstraint(topSeparator.heightAnchor.constraint(equalToConstant: 0))
    }
    
    private func setupDonationCarousel() {
        
    }
    
    private func setupCardSection() {
        setupEmailContainer()
        setupCardContainer()
        setupRememberSwitch()
    }
    
    private func setupEmailContainer() {
        email.placeholder = .localized("email")
        email.delegate = self
        email.keyboardType = .emailAddress
        email.autocapitalizationType = .none
        
        emailInfoLabel.textColor = .black
        emailInfoLabel.font = Style.Font.section
        emailInfoLabel.text = .localized("user_information")
        
        emailContainer.axis = .horizontal
        emailContainer.addArrangedSubview(email)
        emailContainer.layer.borderWidth = 1
        emailContainer.layer.borderColor = Style.Color.grayLight.cgColor
        emailContainer.layer.cornerRadius = 5
        emailContainer.isLayoutMarginsRelativeArrangement = true
        emailContainer.layoutMargins = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        
        emailError.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.emailErrorLabel
        emailError.font = Style.Font.error
        emailError.isHidden = true
        emailError.textColor = Style.Color.error
        emailError.numberOfLines = 0
    }
    
    private func setupCardContainer() {
        cardError.font = Style.Font.error
        cardError.isHidden = true
        cardError.textColor = Style.Color.error
        cardError.numberOfLines = 0
        cardError.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.cardErrorLabel
        
        cardNumber.placeholder = .localized("card_number")
        cardNumber.rightImage = UIImage.fromBundle(named: "unknown")
        cardNumber.delegate = self
        cardNumber.keyboardType = .numberPad
        expiration.placeholder = .localized("expiration")
        expiration.delegate = self
        expiration.keyboardType = .numberPad
        cvc.placeholder = .localized("cvc")
        cvc.rightImage = UIImage.fromBundle(named: "cvc")
        cvc.delegate = self
        cvc.keyboardType = .numberPad
        
        cardContainerLabel.textColor = .black
        cardContainerLabel.font = Style.Font.section
        cardContainerLabel.text = .localized("card_information")
        
        horizontalStack.addArrangedSubview(expiration)
        horizontalStack.addArrangedSubview(cvc)
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = Style.Layout.Padding.standard
        
        separator.backgroundColor = Style.Color.grayLight
        separator.addConstraint(separator.heightAnchor.constraint(equalToConstant: 1))
        
        cardContainer.axis = .vertical
        cardContainer.addArrangedSubview(cardNumber)
        cardContainer.addArrangedSubview(separator)
        cardContainer.addArrangedSubview(horizontalStack)
        cardContainer.setCustomSpacing(5, after: cardNumber)
        cardContainer.setCustomSpacing(5, after: separator)
        
        cardContainer.layer.borderWidth = 1
        cardContainer.layer.borderColor = Style.Color.grayLight.cgColor
        cardContainer.layer.cornerRadius = 5
        cardContainer.isLayoutMarginsRelativeArrangement = true
        cardContainer.layoutMargins = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
    }
    
    private func setupSMSSection() {
        setupSMSInfo()
        setupsmsCode()
    }
    
    private func setupSMSInfo() {
        smsInfoImage.isHidden = true
        smsInfoImage.contentMode = .center
        smsInfoTitle.font = Style.Font.section
        smsInfoTitle.text = .localized("unlock_card_details")
        smsInfoTitle.textAlignment = .center
        smsInfoTitle.isHidden = true
        smsInfoTitle.textColor = .black
        smsInfo.textColor = Style.Color.gray
        smsInfo.font = Style.Font.body
        smsInfo.textAlignment = .center
        smsInfo.isHidden = true
        smsInfo.numberOfLines = 0
        smsInfo.text = .localized("sms_code_info")
    }
    
    private func setupsmsCode() {
        smsCode.delegate = self
        smsCode.isHidden = true
    }
    
    private func setupAdditionalInfoLabel() {
        additionalInfo.numberOfLines = 0
        additionalInfo.textColor = .black
        additionalInfo.font = Style.Font.body
        additionalInfo.isHidden = true
        additionalInfo.numberOfLines = 0
        additionalInfo.textAlignment = .center
    }
    
    private func setupErrorLabel() {
        error.numberOfLines = 0
        error.textColor = Style.Color.error
        error.font = Style.Font.error
        error.isHidden = true
        error.numberOfLines = 0
        error.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.errorLabel
    }
    
    private func setupRememberSwitch() {
        rememberSwitch.title = .localized("save_for_future_payments")
        rememberSwitch.isOn = checkoutRequest.rememberMe
    }
    
    private func setupButton() {
        buttonSeparator.addConstraint(buttonSeparator.heightAnchor.constraint(equalToConstant: Style.Layout.Separator.height))
        buttonSeparator.backgroundColor = Style.Color.grayLight
        
        button.title = "\(String.localized("pay")) \(checkoutRequest.readable)"
        button.addConstraint(button.heightAnchor.constraint(equalToConstant: Style.Layout.Button.height))
        button.didTap = { [weak self] in self?.didTapButton() }
        button.image = UIImage.fromBundle(named: "locker")
        
        bottomSeparator.backgroundColor = .white
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparatorHeightConstraint = bottomSeparator.heightAnchor.constraint(equalToConstant: 0)
        bottomSeparator.addConstraint(bottomSeparatorHeightConstraint!)
    }
    
    private func setupStack() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(stack)
        scrollEqualToStackAnchor = stack.heightAnchor.constraint(equalTo: scroll.heightAnchor)
        scrollHeightAnchor = scroll.heightAnchor.constraint(equalToConstant: 0)
        view.addConstraints([
            stack.leftAnchor.constraint(equalTo: scroll.leftAnchor),
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.rightAnchor.constraint(equalTo: scroll.rightAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            scrollEqualToStackAnchor!
        ])
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.spacing = Style.Layout.Padding.standard
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: Style.Layout.Padding.standard, bottom: 0, right: Style.Layout.Padding.standard)
        
        stack.addArrangedSubview(topSeparator)
        stack.addArrangedSubview(donationCarousel)
        stack.addArrangedSubview(emailInfoLabel)
        stack.addArrangedSubview(emailContainer)
        stack.addArrangedSubview(emailError)
        stack.addArrangedSubview(cardContainerLabel)
        stack.addArrangedSubview(cardContainer)
        stack.addArrangedSubview(cardError)
        stack.addArrangedSubview(rememberSwitch)
        stack.addArrangedSubview(spinnerSection)
        stack.addArrangedSubview(smsInfoImage)
        stack.addArrangedSubview(smsInfoTitle)
        stack.addArrangedSubview(smsInfo)
        stack.addArrangedSubview(smsCode)
        stack.addArrangedSubview(buttonSeparator)
        stack.addArrangedSubview(error)
        stack.addArrangedSubview(additionalInfo)
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(bottomSeparator)
        
        stack.setCustomSpacing(8, after: emailInfoLabel)
        stack.setCustomSpacing(32, after: emailContainer)
        stack.setCustomSpacing(8, after: cardContainerLabel)
        stack.setCustomSpacing(20, after: emailError)
        stack.setCustomSpacing(16, after: cardContainer)
        stack.setCustomSpacing(16, after: error)
        stack.setCustomSpacing(32, after: buttonSeparator)
        stack.setCustomSpacing(8, after: additionalInfo)
        stack.setCustomSpacing(8, after: smsInfoImage)
        stack.setCustomSpacing(8, after: smsInfoTitle)
        stack.setCustomSpacing(44, after: smsInfo)
        stack.setCustomSpacing(44, after: smsCode)
    }
}

extension CheckoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === email {
            cardNumber.becomeFirstResponder()
            return true
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            button.enabled = false
            return true
        }
        guard var textRange = Range(range, in: text) else { return true }
        
        if text[textRange] == " " && textField === cardNumber, let newTextRange = Range(NSRange(location: range.location-1, length: range.length+1), in: text) {
            textRange = newTextRange
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        let backspace = updatedText.count < text.count
        
        if textField === email {
            let cursorLocation = textField.position(from: textField.beginningOfDocument, offset: range.location + string.count)
            email.text = updatedText
            if let cursorLocation = cursorLocation {
                textField.selectedTextRange  = textField.textRange(from: cursorLocation, to: cursorLocation)
            }
            lookup()
            if savedEmail != nil {
                currentCard = CreditCard()
                savedEmail = nil
                cardNumber.text = nil
                expiration.text = nil
                cvc.text = nil
                setRememberSwitchActiveMode(mode: true)
                phoneVerified = false
                cardNumber.rightImage = currentCard.image
            }
            updateButtonStatus()
            return false
        }
        
        if textField === cardNumber {
            let cursorLocation = textField.position(from: textField.beginningOfDocument, offset: range.location + string.count)
            currentCard = CreditCard(number: updatedText)
            cvc.permanentPlaceholder = currentCard.cvcPlaceholder
            cardNumber.rightImage = currentCard.image
            if updatedText.sanitized().count >= currentCard.numberLength {
                cardNumber.text = currentCard.readable
                let formatted = ExpirationDateFormatter.format(inputText: expiration.text ?? .empty, backspace: backspace)
                expiration.permanentPlaceholder = formatted.placeholder
                expiration.becomeFirstResponder()
            } else {
                cardNumber.text = currentCard.readable
            }
            if let cursorLocation = cursorLocation {
                textField.selectedTextRange = textField.textRange(from: cursorLocation, to: cursorLocation)
            }
            if savedEmail != nil {
                currentCard = CreditCard()
                savedEmail = nil
                cardNumber.text = nil
                expiration.text = nil
                cvc.text = nil
                setRememberSwitchActiveMode(mode: true)
                phoneVerified = false
                cardNumber.rightImage = currentCard.image
            }
            updateButtonStatus()
            return false
        }
        
        if textField === expiration {
            let formatted = ExpirationDateFormatter.format(inputText: updatedText, backspace: backspace)
            expiration.permanentPlaceholder = formatted.placeholder
            expiration.text = formatted.text
            if formatted.resignFocus {
                cvc.becomeFirstResponder()
            }
            if savedEmail != nil {
                currentCard = CreditCard()
                savedEmail = nil
                cardNumber.text = nil
                expiration.text = nil
                cvc.text = nil
                setRememberSwitchActiveMode(mode: true)
                phoneVerified = false
                cardNumber.rightImage = currentCard.image
            }
            updateButtonStatus()
            return false
        }
        
        if textField === cvc {
            let cursorLocation = textField.position(from: textField.beginningOfDocument, offset: range.location + string.count)
            if updatedText.count >= currentCard.cvcLength {
                textField.resignFirstResponder()
            }
            cvc.text = String(updatedText.prefix(currentCard.cvcLength))
            if let cursorLocation = cursorLocation {
                textField.selectedTextRange = textField.textRange(from: cursorLocation, to: cursorLocation)
            }
            if savedEmail != nil && phoneVerified {
                currentCard = CreditCard()
                savedEmail = nil
                cardNumber.text = nil
                expiration.text = nil
                cvc.text = nil
                setRememberSwitchActiveMode(mode: true)
                phoneVerified = false
                cardNumber.rightImage = currentCard.image
            }
            updateButtonStatus()
            return false
        }
        
        return true
    }
    
    private func updateButtonStatus() {
        if mode == .sms {
            button.enabled = true
            return
        }
        button.enabled = false
        if mode == .newCard {
            button.enabled =
            !(cardNumber.text ?? .empty).isEmpty &&
            !(expiration.text ?? .empty).isEmpty &&
            !(cvc.text ?? .empty).isEmpty &&
            !(email.text ?? .empty).isEmpty
        }
    }
    
    private func hideErrors() {
        self.error.text = nil
        self.cardError.text = nil
        self.emailError.text = nil
        self.error.isHidden = true
        self.cardError.isHidden = true
        self.emailError.isHidden = true
        email.error = false
        cardNumber.error = false
        expiration.error = false
        cvc.error = false
        
        emailContainer.layer.borderColor = Style.Color.grayLight.cgColor
        cardContainer.layer.borderColor = Style.Color.grayLight.cgColor
        stack.setCustomSpacing(32, after: self.emailContainer)
        if savedEmail == nil {
            stack.setCustomSpacing(16, after: self.cardContainer)
        }
        stack.setCustomSpacing(32, after: buttonSeparator)
    }
    
    private func setupAccessibilityIdentifiers() {
        view.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.identifier
        email.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.email
        cardNumber.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.cardNumber
        expiration.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.expiration
        cvc.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.cvc
        button.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.button
        close.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.closeButton
        rememberSwitch.accessibilityIdentifier = AccessibilityIdentifier.PaymentViewController.rememberSwitch
    }
}

extension CheckoutViewController {
    @objc func adjustForKeyboard(notification: NSNotification) {
        var keyboardFrame: CGRect = .zero
        if let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardFrame = value.cgRectValue
        }
        keyboardFrame = self.view.convert(keyboardFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            keyboardVisible = false
            scrollBottomAnchor?.constant = 0
            scrollEqualToStackAnchor?.isActive = true
            scrollHeightAnchor?.isActive = false
            bottomSeparatorHeightConstraint?.constant = view.safeAreaInsets.bottom
        } else {
            bottomSeparatorHeightConstraint?.constant = Style.Layout.Padding.standard
            keyboardVisible = true
            if stack.bounds.height + keyboardFrame.size.height + header.bounds.height > view.bounds.height - getStatusBarHeight() {
                scrollBottomAnchor?.constant = -keyboardFrame.size.height
                scrollEqualToStackAnchor?.isActive = false
                scrollHeightAnchor?.isActive = true
                scrollHeightAnchor?.constant = view.bounds.height - keyboardFrame.size.height - getStatusBarHeight() - header.bounds.height
            } else {
                scrollBottomAnchor?.constant = -keyboardFrame.size.height
                scrollEqualToStackAnchor?.isActive = true
                scrollHeightAnchor?.isActive = false
            }
        }
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration ?? 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.adjustForKeyboard),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.adjustForKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
}

extension CheckoutViewController: SMSCodeTextFieldDelegate {
    func didEnterCode(code: String) {
        verifySMS()
    }
}
