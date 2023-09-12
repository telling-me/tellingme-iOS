//
//  FeedbackView.swift
//  tellingMe
//
//  Created by 마경미 on 11.09.23.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

final class FeedbackView: UIView {
    public let slider: UISlider = UISlider()
    private let numberLabel: UILabel = UILabel()
    private let questionLabel: UILabel = UILabel()
    private let agreeLabel: UILabel = UILabel()
    private let badLabel: UILabel = UILabel()
    
    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFeedbackQuestion(question: String) {
        questionLabel.text = question
        let attributedString = NSMutableAttributedString(string: question)
        let range = (attributedString.string as NSString).range(of: "*")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Error400, range: range)
        questionLabel.attributedText = attributedString
    }
}

extension FeedbackView {
    private func bindViewModel() {
    }
    
    private func setLayout() {
        addSubviews(numberLabel, questionLabel, slider, badLabel, agreeLabel)
        numberLabel.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.top.leading.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        slider.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(33)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(10)
        }
        
        badLabel.snp.makeConstraints {
            $0.top.equalTo(agreeLabel.snp.top)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(28)
        }

        agreeLabel.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(22)
            $0.leading.bottom.equalToSuperview()
            $0.height.equalTo(28)
        }
    }
    
    private func setStyles() {
        numberLabel.do {
            $0.backgroundColor = .Side500
            $0.cornerRadius = 10
            $0.textColor = .Side100
            $0.textAlignment = .center
        }
        
        questionLabel.do {
            $0.numberOfLines = 2
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Gray8
        }
        
        slider.do {
            $0.tintColor = .Logo
            $0.backgroundColor = .Side300
            $0.maximumValue = 4
            $0.minimumValue = 0
            $0.isContinuous = false
        }
        
        badLabel.do {
            $0.text = "그렇지\n않다"
            $0.textAlignment = .center
            $0.textColor = .Gray5
            $0.font = .fontNanum(.C1_Regular)
            $0.sizeToFit()
        }
        
        agreeLabel.do {
            $0.text = "그렇다"
            $0.textAlignment = .right
            $0.textColor = .Gray5
            $0.font = .fontNanum(.C1_Regular)
            $0.sizeToFit()
        }
    }
}
