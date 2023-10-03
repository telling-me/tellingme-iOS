//
//  HomeQuestionBoxView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

final class HomeQuestionBoxView: BBaseView {

    private let mainQuestionLabel = UILabel()
    private let questionPhraseLabel = UILabel()
    
    override func setStyles() {
        self.setRoundShadowWith(backgroundColor: .Side100, shadowColor: .black, radius: 28,
                                shadowRadius: 10, shadowOpacity: 0.1, xShadowOffset: 0,
                                yShadowOffset: 4)
        
        mainQuestionLabel.do {
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.font = .fontNanum(.B1_Bold)
            $0.textColor = .Logo
            $0.setInterlineSpacing(of: 2)
        }
        
        questionPhraseLabel.do {
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray5
            $0.setInterlineSpacing(of: 1.5)
        }
    }
    
    override func setLayout() {
        self.addSubviews(mainQuestionLabel, questionPhraseLabel)
        
        mainQuestionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        questionPhraseLabel.snp.makeConstraints {
            $0.top.equalTo(mainQuestionLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
}

extension HomeQuestionBoxView {
    
    private func setTitleOfMainQuestion(with title: String) {
        mainQuestionLabel.text = title.replacingOccurrences(of: "\\n", with: "\n")
    }
    
    private func setTitleOfQuestionPhrase(with title: String) {
        questionPhraseLabel.text = title.replacingOccurrences(of: "\\n", with: "\n")
    }
}

extension HomeQuestionBoxView {
    
    func setTitles(question: String, phrase: String) {
        print(question, phrase, "📜📜📜📜📜")
        setTitleOfMainQuestion(with: question)
        setTitleOfQuestionPhrase(with: phrase)
    }
}
