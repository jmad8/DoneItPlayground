import UIKit

@IBDesignable
class CustomView: UIView {

    @IBInspectable var radius : CGFloat = 0 {
        didSet {
            layer.cornerRadius = radius
        }
    }

}
