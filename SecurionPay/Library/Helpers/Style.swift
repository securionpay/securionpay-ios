import Foundation
import UIKit

enum Style {
    enum Alpha {
        static let inactive: CGFloat = 0.7
    }
    
    enum Layout {
        static let cornerRadius: CGFloat = 5.0
        static let borderWidth: CGFloat = 1.0
        
        enum Padding {
            static let huge: CGFloat = 32.0
            static let big: CGFloat = 24.0
            static let standard: CGFloat = 16.0
            static let medium: CGFloat = 8.0
            static let compact: CGFloat = 4.0
        }
        
        enum Button {
            static let height: CGFloat = 48.0
        }
        
        enum Separator {
            static let height: CGFloat = 1.0
        }
    }
    
    enum Color {
        static let primary = UIColor(argb: 0xFF099EF2)
        static let error = UIColor(argb: 0xFFFF5067)
        static let success = UIColor(argb: 0xFF0CE856)
        
        static let gray = UIColor(argb: 0xFF646464)
        static let grayLight = UIColor(argb: 0xFFE5E5E5)
    }
    
    enum Font {
        static var label: UIFont { UIFont(name: "Lato-Bold", size: 10.0)! }
        static var error: UIFont { UIFont(name: "Lato-Bold", size: 12.0)! }
        static var body: UIFont { UIFont(name: "Lato-Regular", size: 14.0)! }
        static var tileLabel: UIFont { UIFont(name: "Lato-Bold", size: 14.0)! }
        static var section: UIFont { UIFont(name: "Lato-Regular", size: 16.0)! }
        static var button: UIFont { UIFont(name: "Montserrat-Bold", size: 14.0)! }
        static var title: UIFont { UIFont(name: "Montserrat-Bold", size: 24.0)! }
    }
}
