import Foundation
import UIKit

extension UIColor {
    convenience init(argb: UInt) {
        self.init(
            red: CGFloat((argb & 0x00FF0000) >> 16) / 255.0,
            green: CGFloat((argb & 0x0000FF00) >> 8) / 255.0,
            blue: CGFloat(argb & 0x000000FF) / 255.0,
            alpha: CGFloat((argb & 0xFF000000) >> 24) / 255.0
        )
    }
}

extension UIColor {
    func colorWithBrightness(brightness: CGFloat) -> UIColor {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            brightness += (brightness - 1.0)
            brightness = max(min(brightness, 1.0), 0.0)
            
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        }
        return self
    }
}
