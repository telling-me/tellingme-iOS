//
//  TodayQuestionView.swift
//  tellingMe
//
//  Created by 마경미 on 31.10.23.
//

import UIKit

import SnapKit
import Then

/// 질문피드백, 스페어 질문 등에 사용된다
final class TodayQuestionView: UIView {
    let questionLabel = UILabel()
    let phraseLabel = UILabel()
}

extension TodayQuestionView {
    private func setStyles() {
        backgroundColor = .Side200
        
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
        addSubviews(questionLabel, phraseLabel)
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        
        phraseLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
    }
}

extension TodayQuestionView {
    func setQuestion(question: Question) {
        questionLabel.text = question.question
        phraseLabel.text = question.phrase
    }
}
