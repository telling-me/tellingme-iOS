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
    
    private var imageSize = 32
    
    private let iconImageView = UIImageView()
    private let iconTitleLabel = UILabel()
    private let iconStackView = UIStackView()
    
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
        
        iconStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .center
        }
    }
    
    private func setLayout() {
        iconStackView.addArrangedSubviews(iconImageView, iconTitleLabel)
        self.addSubview(iconStackView)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.imageSize = Int(appDelegate.deviceWidth/11.7)
        }
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(imageSize)
            $0.top.centerX.equalToSuperview()
        }
        
        iconStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MyPageMainIconCollectionViewCell {
    func configure(imageName: String, title: String) {
        iconImageView.image = UIImage(named: imageName)
        iconTitleLabel.text = title
    }
}
