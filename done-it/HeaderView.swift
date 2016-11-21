import UIKit

@IBDesignable class HeaderView: UIView {
    
    @IBInspectable let color: UIColor = UIColor.themeA()
    
    override func draw(_ rect: CGRect) {
        color.setFill()
        let b = UIBezierPath(rect: rect)
        b.fill()
    }
}
