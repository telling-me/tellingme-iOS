//
//  UIView_.swift
//  tellingMe
//
//  Created by 마경미 on 08.03.23.
//

import UIKit

extension UIView {
    func setGradient(color1: UIColor, color2: UIColor) {
        let shapes = UIView()
        shapes.frame = self.frame
        shapes.clipsToBounds = true
        self.addSubview(shapes)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.03, b: -0.76, c: 0.53, d: 1.03, tx: -0.26, ty: 0.4))
        gradient.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        gradient.position = self.center
        shapes.layer.addSublayer(gradient)
    }

    func setShadow2() {
        self.layer.shadowColor = UIColor(red: 0.68, green: 0.892, blue: 0.823, alpha: 0.9).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
    }

    func setShadow(shadowRadius: CGFloat, cornerRadius: CGFloat) {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
    }
    
    func setTopCornerRadius() {
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
