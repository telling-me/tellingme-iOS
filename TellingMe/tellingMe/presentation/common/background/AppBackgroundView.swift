//
//  AppBackgroundView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 11/11/23.
//

import UIKit

final class AppBackgroundView: BBaseView {

    private let logoImage = UIImageView()
    
    override func setStyles() {
        self.backgroundColor = .Side100
        
        logoImage.do {
            $0.image = ImageLiterals.HomeLogo
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func setLayout() {
        self.addSubview(logoImage)
        
        logoImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
        }
    }
}
