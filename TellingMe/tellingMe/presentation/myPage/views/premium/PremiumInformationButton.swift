//
//  PremiumInformationButton.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/11.
//

import UIKit

final class PremiumInformationButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PremiumInformationButton {
    
    private func setStyles() {
        self.isUserInteractionEnabled = false
        self.isEnabled = false
        self.cornerRadius = 20
        self.backgroundColor = .Primary25
        self.setTitle("프리미엄 모드 출시 준비 중이에요!", for: .normal)
        self.setTitleColor(.Logo, for: .normal)
        self.titleLabel?.font = .fontNanum(.H6_Regular)
    }
}
