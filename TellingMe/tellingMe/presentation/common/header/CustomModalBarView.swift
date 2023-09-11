//
//  CustomNavigationBarView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/24.
//

import UIKit

final class CustomModalBarView: UIView {
    
    private let titleLabel = UILabel()
    let dismissButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomModalBarView {
    private func setStyles() {
        self.backgroundColor = .Side100
        
        titleLabel.do {
            $0.font = .fontNanum(.H6_Bold)
            $0.textColor = .Gray6
        }
        
        dismissButton.do {
            let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .light)
            let systemImage = UIImage(systemName: "xmark", withConfiguration: imageConfiguration)
            $0.setImage(systemImage, for: .normal)
            $0.tintColor = .Gray6
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel, dismissButton)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(27)
        }
        
        dismissButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(25)
        }
    }
}

extension CustomModalBarView {
    func setTitle(with title: String) {
        self.titleLabel.text = title
    }
}
