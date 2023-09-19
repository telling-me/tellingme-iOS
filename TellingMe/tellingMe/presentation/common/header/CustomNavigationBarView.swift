//
//  MyPageHeaderView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import SnapKit
import Then

final class CustomNavigationBarView: UIView {

    let backButton = UIButton()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomNavigationBarView {
    
    private func setStyles() {
        self.backgroundColor = .Side100

        backButton.do {
            $0.setImage(UIImage(named: "ArrowLeft"), for: .normal)
        }
        
        titleLabel.do {
            $0.textColor = .Gray6
            $0.font = .fontNanum(.H6_Bold)
            $0.textAlignment = .center
        }
    }
    
    private func setLayout() {
        self.addSubviews(backButton, titleLabel)
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.top.equalToSuperview().inset(20)
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backButton.snp.centerY)
        }
    }
}

extension CustomNavigationBarView {
    func setTitle(with title: String) {
        self.titleLabel.text = title
    }
    
    func setColor(with color: UIColor) {
        self.backgroundColor = color
    }
}

