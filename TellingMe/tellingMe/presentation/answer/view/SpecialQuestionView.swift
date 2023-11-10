//
//  SpecialQuestionView.swift
//  tellingMe
//
//  Created by 마경미 on 31.10.23.
//

import UIKit

final class SpecialQuestionView: UIView {
    let titleLabel = UILabel()
    let questionLabel = UILabel()
    let phraseLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SpecialQuestionView {
    private func setStyles() {
        backgroundColor = .Primary25
        layer.cornerRadius = 20
        setGradientBorder(borderWidth: 1.5, cornerRadius: 20)
        
        titleLabel.do {
            $0.text = "스페셜 질문"
            $0.textColor = .Logo
            $0.font = .fontNanum(.B2_Bold)
        }
        
        questionLabel.do {
            $0.textColor = .Black
            $0.font = .fontNanum(.B2_Regular)
            $0.numberOfLines = 2
            $0.textAlignment = .left
        }
        
        phraseLabel.do {
            $0.textColor = .Gray6
            $0.font = .fontNanum(.B2_Regular)
            $0.numberOfLines = 2
            $0.textAlignment = .left
        }
    }
    
    private func setLayout() {
        addSubviews(titleLabel, questionLabel, phraseLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        
        phraseLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
    }
}

extension SpecialQuestionView {
    func setQuestion(question: SpareQuestion) {
        questionLabel.text = question.spareQuestion
        phraseLabel.text = question.sparePhrase
    }
}

