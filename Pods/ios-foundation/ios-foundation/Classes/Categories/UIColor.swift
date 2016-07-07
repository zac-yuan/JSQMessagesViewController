
import UIKit

public extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    //
    // MARK: Custom UIColors
    //
    
    public class func babylonPurple() -> UIColor {
        return UIColor(hexString: "#9013fe")
    }
    
    public class func babylonWhite() -> UIColor {
        return UIColor(hexString: "#ffffff")
    }
    
    public class func babylonBlack() -> UIColor {
        return UIColor(hexString: "#000000")
    }
    
    public class func babylonPaleGrey() -> UIColor {
        return UIColor(hexString: "#e6e7ec")
    }
    
    public class func babylonPalePink() -> UIColor {
        return UIColor(hexString: "#efc3e4")
    }
    
    public class func babylonBlue() -> UIColor {
        return UIColor(hexString: "#0000FF")
    }
    
    public class func babylonGreen() -> UIColor {
        return UIColor(hexString: "#00FF00")
    }
    
    public class func babylonRandomColor() -> UIColor {

        let hue:CGFloat = CGFloat(drand48()%256/256.0)
        let saturation:CGFloat = CGFloat(drand48()%128/256.0)+0.5
        let brightness:CGFloat = CGFloat(drand48()%128/256.0)+0.5
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        
    }
}