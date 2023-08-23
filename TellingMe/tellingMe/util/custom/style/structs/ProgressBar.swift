//
//  ProgressBar.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import UIKit

final class GradientProgressBar : UIProgressView {
    
    // MARK: - Properties
    
    /// An array of CGColorRef objects defining the color of each gradient stop. Animatable.
    var gradientColors: [CGColor] = [#colorLiteral(red: 0.2666666667, green: 0.1803921569, blue: 0.8470588235, alpha: 1).cgColor, #colorLiteral(red: 0.8392156863, green: 0.2588235294, blue: 0.5333333333, alpha: 1).cgColor, #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).cgColor, #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor] {
        didSet {
            gradientLayer.colors = gradientColors
        }
    }

    
    /** The radius to use when drawing rounded corners for the gradient layer and progress view backgrounds. Animatable.
    *   The default value of this property is 0.0.
    */
    @IBInspectable override var cornerRadius: CGFloat {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
    override var trackTintColor: UIColor? {
        didSet {
            if trackTintColor != UIColor.clear {
                backgroundColor = trackTintColor
                trackTintColor = UIColor.clear
            }
        }
    }
    
    override var progressTintColor: UIColor? {
        didSet {
            if progressTintColor != UIColor.clear {
                progressTintColor = UIColor.clear
            }
        }
    }
    
    lazy private var gradientLayer: CAGradientLayer = self.initGradientLayer()

    // MARK: - init methods
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientLayer()
    }
    
    override func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)
        updateGradientLayer()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        self.layer.cornerRadius = cornerRadius
        self.layer.addSublayer(gradientLayer)
        progressTintColor = UIColor.clear
        gradientLayer.colors = gradientColors
    }
    
    private func initGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = sizeByPercentage(originalRect: bounds, width: CGFloat(progress))
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position = CGPoint(x: 0, y: 0)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.masksToBounds = true
        return gradientLayer
    }
    
    private func updateGradientLayer() {
        gradientLayer.frame = sizeByPercentage(originalRect: bounds, width: CGFloat(progress))
        gradientLayer.cornerRadius = cornerRadius
    }
    
    private func sizeByPercentage(originalRect: CGRect, width: CGFloat) -> CGRect {
        let newSize = CGSize(width: originalRect.width * width, height: originalRect.height)
        return CGRect(origin: originalRect.origin, size: newSize)
    }
}
