//
//  ChangeToOriginQuestionView.swift
//  tellingMe
//
//  Created by 마경미 on 12.11.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class ChangeToOriginQuestionView: UIView {
    private let disposeBag = DisposeBag()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let todayQuestionView = TodayQuestionView()
    private let buttonStackView = UIStackView()
    private let cancelButton = TeritaryTextButton()
    private let okButton = SecondaryTextButton()
    
    var okButtonTapObserver: Observable<Void> {
        return self.okButton.rx.tap.asObservable()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChangeToOriginQuestionView {
    private func bind() {
        okButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.isHidden = true
            })
            .disposed(by: disposeBag)
        cancelButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.isHidden = true
            })
            .disposed(by: disposeBag)
    }
    
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
        containerView.addSubviews(titleLabel, todayQuestionView, buttonStackView)
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
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(todayQuestionView.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(42)
            $0.height.equalTo(55)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

extension ChangeToOriginQuestionView {
    func animate() {
        self.containerView.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }
    
    func setQuestion(todayQuestion: Question) {
        todayQuestionView.setQuestion(question: todayQuestion)
    }
}

