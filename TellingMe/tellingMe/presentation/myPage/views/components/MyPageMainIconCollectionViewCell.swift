//
//  MyPageMainIconCollectionViewCell.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import SnapKit
import Then

final class MyPageMainIconCollectionViewCell: UICollectionViewCell {
    
    private let iconImageView = UIImageView()
    private let iconTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageMainIconCollectionViewCell {
    
    private func setStyles() {
        self.backgroundColor = .clear
        
        iconImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        iconTitleLabel.do {
            $0.font = .fontNanum(.C1_Regular)
            $0.textAlignment = .center
            $0.textColor = .Gray7
        }
    }
    
    private func setLayout() {
        self.addSubviews(iconImageView, iconTitleLabel)
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.top.centerX.equalToSuperview()
        }
        
        iconTitleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(8)
            $0.centerX.equalTo(iconImageView.snp.centerX)
        }
    }
}

extension MyPageMainIconCollectionViewCell {
    func configure(imageUrl: String, title: String) {
        iconImageView.load(url: imageUrl)
        iconTitleLabel.text = title
    }
}
