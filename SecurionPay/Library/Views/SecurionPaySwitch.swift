import Foundation
import UIKit

final class SecurionPaySwitch: UIView {
    private let label = UILabel()
    private let enabled = UISwitch()
    
    var title: String? {
        set { label.text = newValue }
        get { label.text }
    }
    
    var isOn: Bool {
        set { enabled.isOn = newValue }
        get { enabled.isOn }
    }
    
    var isEnabled: Bool {
        set { enabled.isEnabled = newValue}
        get { enabled.isEnabled }
    }
    
    var switchHidden: Bool {
        set { enabled.isHidden = newValue}
        get { enabled.isHidden }
    }
    
    override var accessibilityIdentifier: String? {
        set { enabled.accessibilityIdentifier = newValue }
        get { enabled.accessibilityIdentifier }
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
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addConstraints([
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        label.font = Style.Font.body
        label.textColor = .black
        enabled.translatesAutoresizingMaskIntoConstraints = false
        addSubview(enabled)
        addConstraints([
            enabled.topAnchor.constraint(equalTo: topAnchor),
            enabled.bottomAnchor.constraint(equalTo: bottomAnchor),
            enabled.rightAnchor.constraint(equalTo: rightAnchor),
            enabled.leftAnchor.constraint(equalTo: label.rightAnchor)
        ])
        enabled.onTintColor = Style.Color.primary
    }
}
