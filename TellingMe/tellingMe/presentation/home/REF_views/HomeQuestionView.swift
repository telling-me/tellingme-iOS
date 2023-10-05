//
//  HomeQuestionView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

import SnapKit

final class HomeQuestionView: BBaseView {

    private let shapeStickerView = UIImageView()
    private let completeLabel = UILabel()
    let todayDateView = HomeSubDateView()
    let questionBoxView = HomeQuestionBoxView()
    let writeButton = HomeWritingButton(frame: .zero)
    
    override func setStyles() {
        self.backgroundColor = .clear
        
        shapeStickerView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = ImageLiterals.HomeSticker
            $0.backgroundColor = .clear
        }
        
        completeLabel.do {
            $0.backgroundColor = .clear
            $0.textAlignment = .center
            $0.textColor = .Logo
            $0.text = "답변 완료!"
            $0.font = .fontNanum(.C1_Bold)
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.addSubviews(completeLabel, writeButton, questionBoxView,
                         shapeStickerView, todayDateView)
        
        completeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(55)
        }
        
        questionBoxView.snp.makeConstraints {
            $0.bottom.equalTo(writeButton.snp.top).offset(-36)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.greaterThanOrEqualTo(142)
        }
        
        shapeStickerView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(90)
            $0.centerX.equalTo(questionBoxView.snp.centerX)
            $0.centerY.equalTo(questionBoxView.snp.top)
        }
        
        todayDateView.snp.makeConstraints {
            $0.bottom.equalTo(questionBoxView.snp.top).offset(-53)
            $0.height.equalTo(30)
            $0.width.equalTo(125)
            $0.centerX.equalToSuperview()
        }
    }
}

extension HomeQuestionView {
    func isAnswered(_ check: Bool) {
        switch check {
        case true:
            self.completeLabel.isHidden = false
        case false:
            self.completeLabel.isHidden = true
        }
    }
}
