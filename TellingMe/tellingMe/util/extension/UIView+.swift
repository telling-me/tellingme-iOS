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
//
//    func setShadow() {
//        let shadowPath: UIBezierPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0)
//        let layer = CALayer()
//        layer.shadowPath = shadowPath.cgPath
//        layer.shadowColor = UIColor(red: 0.902, green: 0.929, blue: 0.8, alpha: 1).cgColor
//        layer.shadowOpacity = 1
//        layer.shadowRadius = 20
//        layer.shadowOffset = CGSize(width: 0, height: 4)
//        layer.bounds = self.bounds
//        layer.position = self.center
//        self.layer.addSublayer(layer)
//    }

    func setShadow(color: UIColor, radius: CGFloat) {
        // 이미지 뷰 레이어 설정
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 4)

//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }

    func setShadow2() {
        layer.shadowColor = UIColor(red: 0.765, green: 0.967, blue: 0.866, alpha: 0.5).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
