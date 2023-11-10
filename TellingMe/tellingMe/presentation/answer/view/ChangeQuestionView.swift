//
//  SpareView.swift
//  tellingMe
//
//  Created by 마경미 on 31.10.23.
//

import UIKit

import SnapKit
import Then

final class ChangeQuestionView: UIView {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let todayQuestionView = TodayQuestionView()
    private let changeImage = UIImageView()
    private let specialQuestionView = SpecialQuestionView()
    private let captionLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let cancelButton = TeritaryTextButton()
    private let okButton = SecondaryTextButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChangeQuestionView {
    private func setStyles() {
        self.backgroundColor = .AlphaBlackColor

        containerView.do {
            $0.backgroundColor = .Side100
            $0.layer.cornerRadius = 28
            $0.setTopCornerRadius()
        }
        
        titleLabel.do {
            $0.text = "오늘의 질문을 바꿀 수 있어요!"
            $0.font = .fontNanum(.H6_Bold)
            $0.textColor = .Black
        }
        
        captionLabel.do {
            let text = "  스페셜 질문은 모두의 공간에 공개할 수 없어요."

            let attachment = NSTextAttachment()
            attachment.image = UIImage(systemName: "info.circle")
            attachment.bounds = CGRect(x: 0, y: -3, width: 16, height: 16)

            let attributedString = NSMutableAttributedString(string: "")
            attributedString.append(NSAttributedString(attachment: attachment))
            attributedString.append(NSAttributedString(string: text))

            $0.attributedText = attributedString
            $0.font = .fontNanum(.C1_Regular)
            $0.textColor = .Gray6
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 15
        }
        
        cancelButton.do {
            $0.setText(text: "취소")
        }
        
        okButton.do {
            $0.setText(text: "바꿀래요")
        }
    }
    
    private func setLayout() {
        addSubviews(containerView)
        containerView.addSubviews(titleLabel, todayQuestionView, changeImage,
                                  specialQuestionView, captionLabel, buttonStackView)
        buttonStackView.addArrangedSubviews(cancelButton, okButton)
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.horizontalEdges.equalToSuperview().inset(32)
        }
        
        todayQuestionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.height.equalTo(100)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        changeImage.snp.makeConstraints {
            $0.top.equalTo(todayQuestionView.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        specialQuestionView.snp.makeConstraints {
            $0.top.equalTo(changeImage.snp.bottom).offset(7)
            $0.height.equalTo(134)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(specialQuestionView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(32)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(captionLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(42)
            $0.height.equalTo(55)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

extension ChangeQuestionView {
    func animate() {
        self.containerView.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }
    
    func setQuestion(todayQuestion: Question, specialQuestion: SpareQuestion) {
        todayQuestionView.setQuestion(question: todayQuestion)
        specialQuestionView.setQuestion(question: specialQuestion)
    }
}
