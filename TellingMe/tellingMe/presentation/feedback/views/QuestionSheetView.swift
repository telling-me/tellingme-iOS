//
//  QuestionSheetView.swift
//  tellingMe
//
//  Created by 마경미 on 12.09.23.
//

import UIKit

import RxCocoa
import RxRelay
import RxSwift
import SnapKit
import Then

final class QuestionSheetView: UIView {
    private let sheetView = UIView()
    private let backgroundView = UIView()
    private let titleLabel = UILabel()
    private let containerView = UIView()
    private let questionLabel = UILabel()
    private let subQuestionLabel = UILabel()
    public let okButton = SecondaryTextButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit { }
}

extension QuestionSheetView {
    private func setLayout() {
        sheetView.snp.removeConstraints()
        
        addSubviews(backgroundView, sheetView)
        sheetView.addSubviews(titleLabel, containerView, okButton)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        sheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0)
        }
    }
    
    private func setStyles() {
        backgroundView.do {
            $0.backgroundColor = UIColor(red: 0.096, green: 0.096, blue: 0.096, alpha: 0.28)
        }
        
        sheetView.do {
            $0.layer.cornerRadius = 28
            $0.backgroundColor = .Side100
        }
        
        titleLabel.do {
            $0.font = .fontNanum(.H6_Bold)
            $0.textColor = .Black
            $0.textAlignment = .left
            $0.text = "오늘의 질문"
        }
        
        containerView.do {
            $0.backgroundColor = .Side200
            $0.cornerRadius = 20
        }
        
        questionLabel.do {
            $0.textColor = .black
            $0.font = .fontNanum(.B2_Regular)
            $0.numberOfLines = 2
        }
        
        subQuestionLabel.do {
            $0.textColor = .Gray6
            $0.font = .fontNanum(.B2_Regular)
            $0.numberOfLines = 2
        }
        
        okButton.do {
            $0.setText(text: "확인")
        }
    }
}

extension QuestionSheetView {
    private func setSheetLayout() {
        sheetView.snp.removeConstraints()
        
        containerView.addSubviews(questionLabel, subQuestionLabel)
        
        sheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.38)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(42)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(124)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        
        subQuestionLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(32)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        
        okButton.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
    }
}

extension QuestionSheetView {
    func animate() {
        setSheetLayout()
    }
    
    func dismissAnimate() {
        setLayout()
    }
    
    func setQuestion(data: QuestionResponse) {
        questionLabel.text = data.title
        questionLabel.sizeToFit()
        subQuestionLabel.text = data.phrase
        subQuestionLabel.sizeToFit()
    }
}
