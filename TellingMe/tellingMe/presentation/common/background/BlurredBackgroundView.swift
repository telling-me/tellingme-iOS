//
//  BlurredBackgroundView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/25.
//

import UIKit

final class BlurredBackgroundView: UIView {
   
    private var blurStyle: UIBlurEffect.Style?
    private var backgroundTintColor: UIColor = .black
    private var colorOpacity: CGFloat!
    
    private let blurView = UIVisualEffectView()
    
    init(frame: CGRect, backgroundColor: UIColor, opacity: CGFloat = 0.5, blurEffect: UIBlurEffect.Style? = nil) {
        self.blurStyle = blurEffect
        self.backgroundTintColor = backgroundColor
        self.colorOpacity = opacity
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BlurredBackgroundView {
    func setStyles() {
        if colorOpacity >= 1.0 {
            colorOpacity = 1.0
        }
        self.backgroundColor = backgroundTintColor.withAlphaComponent(colorOpacity)
        
        guard let blurStyle else { return }
        blurView.effect = UIBlurEffect(style: blurStyle)
    }
    
    func setLayout() {
        self.addSubviews(blurView)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
