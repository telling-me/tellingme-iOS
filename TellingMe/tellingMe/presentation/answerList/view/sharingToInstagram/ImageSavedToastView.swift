//
//  ImageSavedToastView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/12.
//

import UIKit

import SnapKit
import Then

final class ImageSavedToastView: UIView {
    
    enum ImageSavedSuccess {
        case successed
        case failed
    }
    
    private var type: ImageSavedSuccess
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    
    init(frame: CGRect, type: ImageSavedSuccess) {
        self.type = type
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageSavedToastView {
    private func setStyles() {
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        
        iconImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.font = .fontNanum(.C1_Bold)
            $0.textColor = .Gray7
        }
        
        switch type {
        case .successed:
            self.backgroundColor = .Primary25
            iconImageView.image = UIImage(systemName: "checkmark.square.fill", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .Primary500
            titleLabel.text = "이미지가 앨범에 성공적으로 저장됐습니다."
        case .failed:
            self.backgroundColor = .Error200
            iconImageView.image = UIImage(systemName: "xmark.app.fill", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .Error500
            titleLabel.text = "이미지를 앨범에 저장하지 못했습니다."
        }
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.Gray6.cgColor
        self.layer.masksToBounds = false
    }
    
    private func setLayout() {
        self.addSubviews(iconImageView, titleLabel)
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(15)
            $0.centerY.equalToSuperview()
        }
    }
}
