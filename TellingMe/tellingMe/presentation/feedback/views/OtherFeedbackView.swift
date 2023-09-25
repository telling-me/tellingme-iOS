//
//  OtherFeedbackView.swift
//  tellingMe
//
//  Created by 마경미 on 23.09.23.
//

import UIKit

import RxCocoa
import RxRelay
import RxSwift
import SnapKit
import Then

final class OtherFeedbackView: UIView {
    private let disposeBag = DisposeBag()
    
    private let numberLabel = UILabel()
    private let questionLabel = UILabel()
    private let containerView = UIView()
    private let textView = CustomTextView()
    
    let textObservable = BehaviorRelay<String?>(value: nil)
    
    init(frame: CGRect, index: Int?) {
        super.init(frame: frame)
        bindViewModel()
        setLayout()
        setStyles()
        setNumberLabel(index: index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OtherFeedbackView {
    private func bindViewModel() {
        textView.rx.text
            .bind(to: textObservable)
            .disposed(by: disposeBag)
    }

    private func setLayout() {
        addSubviews(numberLabel, questionLabel, containerView, textView)
        containerView.addSubview(textView)
        
        numberLabel.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.top.leading.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(190)
            $0.bottom.equalToSuperview()
        }
        
        textView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.verticalEdges.equalToSuperview().inset(20)
        }
    }
    
    private func setStyles() {
        numberLabel.do {
            $0.backgroundColor = .Side500
            $0.textColor = .Side100
            $0.textAlignment = .center
            $0.clipsToBounds = true
            $0.cornerRadius = 10
            $0.font = .fontNanum(.C1_Bold)
        }
        
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

extension OtherFeedbackView {
    private func setNumberLabel(index: Int?) {
        if let index = index {
            numberLabel.text = "\(index)"
        } else {
            numberLabel.isHidden = true
            numberLabel.snp.updateConstraints {
                $0.height.equalTo(0)
            }
        }
    }
}
