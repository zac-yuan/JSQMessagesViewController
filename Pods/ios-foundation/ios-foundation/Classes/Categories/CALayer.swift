
import UIKit

public extension CALayer {
    
   public func roudedBubbleMaskForRect(rect:CGRect, corners:UIRectCorner) -> CALayer {
        let cornerRadio: CGSize = CGSizeMake(foundationConstants.kDefaultCornerRadio, foundationConstants.kDefaultCornerRadio)
        let maskPath: UIBezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerRadio)
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.CGPath
        return maskLayer
    }
    
}