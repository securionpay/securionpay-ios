import Foundation
import UIKit

final class FontsLoader {
    static func loadFontsIfNeeded() {
        let fonts = ["Lato-Bold", "Lato-Regular", "Montserrat-Bold"]
        
        let fontFamilyNames = UIFont.familyNames
        if !fontFamilyNames.contains("Lato") {
            fonts.forEach {
                UIFont.registerFont(bundle: Bundle.securionPay, fontName: $0, fontExtension: "ttf")
            }
        }
    }
}
