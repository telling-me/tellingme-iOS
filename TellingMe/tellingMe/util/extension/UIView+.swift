//
//  UIView_.swift
//  tellingMe
//
//  Created by 마경미 on 08.03.23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
//    func setGradient(color1: UIColor, color2: UIColor) {
//        let shapes = UIView()
//        shapes.frame = self.frame
//        shapes.clipsToBounds = true
//        self.addSubview(shapes)
//
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.colors = [color1.cgColor, color2.cgColor]
//        gradient.locations = [0.0, 1.0]
//        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
//        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
//        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.03, b: -0.76, c: 0.53, d: 1.03, tx: -0.26, ty: 0.4))
//        gradient.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
//        gradient.position = self.center
//        shapes.layer.addSublayer(gradient)
//    }

//    func setShadow2() {
//        self.layer.shadowColor = UIColor(red: 0.68, green: 0.892, blue: 0.823, alpha: 0.9).cgColor
//        self.layer.shadowOpacity = 1
//        self.layer.shadowRadius = 20
//        self.layer.shadowOffset = CGSize(width: 0, height: 4)
//        layer.masksToBounds = false
//    }
//
    func setShadow(shadowRadius: CGFloat) {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
    }

    func setTopCornerRadius() {
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setBorder(borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func setGradientBorder(borderWidth: CGFloat, cornerRadius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [UIColor(hex: "#7CEFA7").cgColor, UIColor(hex: "#8FD3F4").cgColor]
        gradientLayer.borderWidth = borderWidth
        
        gradientLayer.cornerRadius = cornerRadius
        
        layer.addSublayer(gradientLayer)
    }
}

extension UIView {
    func scaleView(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scaleView(by: scale)
        }
    }
    
    /**
     UIView 는 디바이스 내에 한정된 픽셀에서 만들어진 작은 해상도의 View 인데, 그대로 공유를 하게 되면 깨지게 되어 스케일 업을 시켜야 한다. 추천하는 사이즈는 3~5 이다. 그 이상으로 하게 되면 지나치게 용량이 커지게 된다.
     */
    func saveUIViewWithScale(with scale: CGFloat? = nil) -> Data? {
        let newScale = scale ?? UIScreen.main.scale
        self.scaleView(by: newScale)
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale
        let renderer = UIGraphicsImageRenderer(bounds: bounds, format: format)
        let image = renderer.image { context in
            self.layer.render(in: context.cgContext)
        }
        let imageData = image.pngData()
        
        return imageData
    }
    
    /**
     Round Shadow 를 추가합니다.
     - Opacity 는 0.0 - 1.0 사이의 범위에 있습니다.
     - x, y 는 CGRect 의 방향을 따릅니다.
     - *단, 주의점은 SuperView 에 종속되어 있고 SuperView 의 masksToBounds 의 속성이 바뀌면 해당 메서드는 작동하지 않을 수 있습니다.
     */
    func setRoundShadowWith(backgroundColor: UIColor, shadowColor: UIColor, radius: CGFloat, shadowRadius: CGFloat, shadowOpacity: Float, xShadowOffset: CGFloat, yShadowOffset: CGFloat) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: xShadowOffset, height: yShadowOffset)
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.masksToBounds = false
    }
}
