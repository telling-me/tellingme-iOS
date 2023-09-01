//
//  HeaderViewWithEmotionView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/01.
//

import UIKit

import SnapKit
import Then

final class HeaderViewWithEmotionView: UIView {

    let backButton = UIButton()
    private let emotionImageView = UIImageView()
    private let emotionTitleLabel = UILabel()
    private let emotionStackView = UIStackView()
    private let questionTitleLabel = UILabel()
    private let questionSubTitleLabel = UILabel()
    private let publishedDateLabel = UILabel()
    private let dividerLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderViewWithEmotionView {

    private func setStyles() {
        self.backgroundColor = .Side100
        
        backButton.do {
            $0.setImage(UIImage(named: "ArrowLeft"), for: .normal)
        }
        
        emotionImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
        }
        
        emotionTitleLabel.do {
            $0.textColor = .Gray6
            $0.backgroundColor = .Side200
            $0.layer.cornerRadius = 4
            $0.font = .fontNanum(.B2_Bold)
        }
        
        emotionStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
        }
        
        questionTitleLabel.do {
            $0.font = .fontNanum(.B1_Bold)
            $0.textColor = .Gray7
            $0.backgroundColor = .clear
            $0.textAlignment = .center
            $0.numberOfLines = 1
        }
        
        questionSubTitleLabel.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray7
            $0.backgroundColor = .clear
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        publishedDateLabel.do {
            $0.font = .fontNanum(.C1_Regular)
            $0.textColor = .Side500
        }
        
        dividerLine.do {
            $0.backgroundColor = .Side300
        }
    }
    
    private func setLayout() {
        emotionStackView.addArrangedSubviews(emotionImageView, emotionTitleLabel)
        self.addSubviews(backButton, emotionStackView, questionTitleLabel, questionSubTitleLabel, publishedDateLabel, dividerLine)
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.top.equalToSuperview().inset(20)
            $0.size.equalTo(24)
        }
        
        emotionStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        questionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(emotionStackView.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
        
        questionSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(questionTitleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
        
        publishedDateLabel.snp.makeConstraints {
            $0.top.equalTo(questionSubTitleLabel.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        dividerLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(2)
        }
    }
}

extension HeaderViewWithEmotionView {
    func configure(data: AnswerForAlarmModel) {
        guard let emotion = Emotions(intValue: data.emotion) else { return }
        emotionImageView.image = UIImage(named: emotion.rawValue)
        emotionTitleLabel.text = emotion.stringValue
        questionTitleLabel.text = data.question
        questionSubTitleLabel.text = data.subQuestion
        publishedDateLabel.text = data.publshedDate
    }
}
