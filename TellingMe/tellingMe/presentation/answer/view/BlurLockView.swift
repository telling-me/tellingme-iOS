//
//  BlurLockView.swift
//  tellingMe
//
//  Created by 마경미 on 29.11.23.
//

import UIKit

final class BlurLockView: BBaseView {
    let lockImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setStyles() {
        layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        alpha = 0.5
        
        lockImageView.do {
            $0.image = ImageLiterals.Lock
        }
    }
    
    override func setLayout() {
        
    }
}
