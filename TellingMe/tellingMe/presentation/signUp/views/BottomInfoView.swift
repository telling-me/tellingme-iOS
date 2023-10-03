//
//  BottoinInfoView.swift
//  tellingMe
//
//  Created by 마경미 on 03.10.23.
//

import UIKit

import SnapKit
import Then

class BottomInfoView: UIView {

    private let titleLabel = UILabel()
    private let captionLabel = UILabel()
    private let button = TeritaryTextButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomInfoView {
    private func bindViewModel() {
        
    }
    
    private func setLayout() {
        addSubviews(titleLabel, captionLabel, button)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17)
        }
        
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(captionLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(55)
        }
    }
    
    private func setStyles() {
        backgroundColor = .Black
        titleLabel.do {
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Black
            $0.textAlignment = .center
        }
        
        captionLabel.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray5
            $0.textAlignment = .center
        }
        
        button.do {
            $0.setText(text: "확인")
        }
    }
}
