import Foundation
import UIKit

final class SpinnerSection: UIView {
    private let spinner = SecurionPayButton()
    private let info = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func show() {
        
    }
    
    func hide() {
        
    }
    
    private func commonInit() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.changeState(to: .pending, animated: false)
        addSubview(spinner)
        addConstraints([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            spinner.heightAnchor.constraint(equalToConstant: Style.Layout.Button.height),
            spinner.widthAnchor.constraint(equalToConstant: Style.Layout.Button.height),
        ])
        
        info.translatesAutoresizingMaskIntoConstraints = false
        addSubview(info)
        info.text = .localized("loading_payment_info")
        info.textAlignment = .center
        info.font = Style.Font.body
        info.numberOfLines = 0
        info.textColor = Style.Color.gray
        addConstraints([
            spinner.bottomAnchor.constraint(equalTo: info.topAnchor, constant: -16),
            info.leftAnchor.constraint(equalTo: leftAnchor),
            info.rightAnchor.constraint(equalTo: rightAnchor),
            info.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }
}
