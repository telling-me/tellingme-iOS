//
//  PremiumInformationFooterView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/11.
//

import UIKit

import SnapKit
import Then

final class PremiumInformationFooterView: UICollectionReusableView {
    
    private let iconImageView = UIImageView()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PremiumInformationFooterView {
    
    private func setStyles() {
        self.backgroundColor = .clear
        
        iconImageView.do {
            $0.image = UIImage(named: "informationIcon")
            $0.contentMode = .scaleAspectFit
        }
        
        descriptionLabel.do {
            $0.text = "프리미엄 모드가 곧 출시 예정이에요. 프리미엄 출시를 기대해주세요!"
            $0.numberOfLines = 2
            $0.font = .fontNanum(.C1_Regular)
            $0.textColor = .Gray7
        }
    }
    
    private func setLayout() {
        self.addSubviews(iconImageView, descriptionLabel)
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
            $0.size.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(4)
            $0.top.equalTo(iconImageView.snp.top)
            $0.trailing.equalToSuperview()
        }
    }
}

