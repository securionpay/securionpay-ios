import Foundation
import UIKit

@objc(SPSecurionPayStyle)
public class SecurionPayStyle: NSObject {
    @objc(SPButtonStyle)
    public class Button: NSObject {
        @objc public static var defaultPrimary: Button { Button() }
        @objc public static var defaultSecondary: Button {
            let button = Button.defaultPrimary
            button.color = .white
            button.textColor = .black
            return button
        }
        @objc public var height: CGFloat = Style.Layout.Button.height
        @objc public var color: UIColor = Style.Color.primary
        @objc public var cornerRadius: CGFloat = Style.Layout.cornerRadius
        @objc public var textColor: UIColor = .white
        @objc public var font: UIFont = Style.Font.button
    }
    @objc(SPToolbarButtonStyle)
    public class ToolbarButton: NSObject {
        @objc public static var `default`: ToolbarButton { ToolbarButton() }
        @objc public var textColor: UIColor = .black
        @objc public var fontName: String = "Lato-Regular"
        @objc public var fontSize: CGFloat = 14.0
    }
    @objc(SPTitleLabelStyle)
    public class TitleLabel: NSObject {
        @objc public static var `default`: TitleLabel { TitleLabel() }
        @objc public var textColor: UIColor = .black
        @objc public var fontName: String = "Lato-Bold"
        @objc public var fontSize: CGFloat = 16.0
    }
    @objc(SPHeading1LabelStyle)
    public class Heading1Label: NSObject {
        @objc public static var `default`: Heading1Label { Heading1Label() }
        @objc public var textColor: UIColor = .black
        @objc public var fontName: String = "Montserrat-Bold"
        @objc public var fontSize: CGFloat = 24.0
        @objc public var textAlignment: NSTextAlignment = .left
    }
    @objc(SPHeading2LabelStyle)
    public class Heading2Label: NSObject {
        @objc public static var `default`: Heading2Label { Heading2Label() }
        @objc public var textColor: UIColor = .black
        @objc public var fontName: String = "Lato-Regular"
        @objc public var fontSize: CGFloat = 16.0
    }
    @objc(SPErrorLabelStyle)
    public class ErrorLabel: NSObject {
        @objc public static var `default`: ErrorLabel { ErrorLabel() }
        @objc public var textColor: UIColor = Style.Color.error
        @objc public var font: UIFont = Style.Font.error
    }
    @objc(SPBody1LabelStyle)
    public class Body1Label: NSObject {
        @objc public static var `default`: Body1Label { Body1Label() }
        @objc public var textColor: UIColor = .black
        @objc public var fontName: String = "Lato-Regular"
        @objc public var fontSize: CGFloat = 12.0
    }
    @objc(SPBody2LabelStyle)
    public class Body2Label: NSObject {
        @objc public static var `default`: Body2Label { Body2Label() }
        @objc public var textColor: UIColor = .lightGray
        @objc public var fontName: String = "Lato-Regular"
        @objc public var fontSize: CGFloat = 12.0
    }
    @objc(SPInputStyle)
    public class Input: NSObject {
        @objc public static var `default`: Input { Input() }
        @objc public var textColor: UIColor = .black
        @objc public var placeholderColor: UIColor = .lightGray
        @objc public var fontName: String = "Lato-Regular"
        @objc public var fontSize: CGFloat = 16.0
    }

    @objc public static var `default`: SecurionPayStyle { SecurionPayStyle() }

    @objc public var backgroundColor: UIColor = .white
    @objc public var titleLabel: TitleLabel = .default
    @objc public var toolbarCancelButton: ToolbarButton = .default
    @objc public var primaryButton: Button = .defaultPrimary
    @objc public var secondaryButton: Button = .defaultSecondary
    @objc public var heading1Label: Heading1Label = .default
    @objc public var heading2Label: Heading2Label = .default
    @objc public var errorLabel: ErrorLabel = .default
    @objc public var body1Label: Body1Label = .default
    @objc public var body2Label: Body2Label = .default
    @objc public var input: Input = .default
}
