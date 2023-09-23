//
//  OtherFeedbackView.swift
//  tellingMe
//
//  Created by 마경미 on 23.09.23.
//

import UIKit

import SnapKit
import Then

final class OtherFeedbackView: UIView {
    private let questionLabel: UILabel = UILabel()
    private let containerView: UIView = UIView()
    private let textView: CustomTextView = CustomTextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OtherFeedbackView {
    private func setLayout() {
        addSubviews(questionLabel, containerView, textView)
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(38)
        }
        containerView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(190)
            $0.bottom.equalToSuperview()
        }
        containerView.addSubview(textView)
        textView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.verticalEdges.equalToSuperview().inset(20)
        }
    }
    
    private func setStyles() {
        questionLabel.do {
            $0.text = "그 외 하고 싶은 말을\n자유롭게 적어주세요."
            $0.textColor = .Gray8
            $0.font = .fontNanum(.B1_Regular)
            $0.numberOfLines = 2
        }
        containerView.do {
            $0.cornerRadius = 18
            $0.backgroundColor = .Side200
        }
        textView.do {
            $0.placeholder = "500자 이내"
            $0.backgroundColor = .clear
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Gray7
        }
    }
}
