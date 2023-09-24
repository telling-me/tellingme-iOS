//
//  GoodFeedbackViewController.swift
//  tellingMe
//
//  Created by 마경미 on 12.09.23.
//

import UIKit
import RxSwift
import RxCocoa

final class GoodFeedbackViewController: UIViewController {
    private let viewModel = GoodFeedbackViewModel()

    private let headerView: InlineHeaderView = InlineHeaderView()
    private let scrollView: UIScrollView = UIScrollView()
    private let scrollContainerView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let stackView: UIStackView = UIStackView()
    private let lastFeedbackView: OtherFeedbackView = OtherFeedbackView()
    private let bottomContainerView: UIView = UIView()
    private let submitButton: SecondaryTextButton = SecondaryTextButton()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Side100
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    override func viewDidLayoutSubviews() {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            guard let view = view as? FeedbackView else {
                return
            }
            view.slider.rx.value
                .bind(to: viewModel.inputs.sliderObservables[index])
                .disposed(by: disposeBag)
        }
    }
}

extension GoodFeedbackViewController {
    private func bindViewModel() {
        headerView.leftButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.popViewController()
            })
            .disposed(by: disposeBag)
        headerView.rightButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        lastFeedbackView.textObservable
            .bind(to: viewModel.inputs.textObservables)
            .disposed(by: disposeBag)
        submitButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.postFeedback()
//                let vc = FinishFeedbackViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubviews(headerView, scrollView, bottomContainerView)
        headerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(66)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-63)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
        }
        bottomContainerView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(63)
        }
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        scrollContainerView.addSubviews(titleLabel, stackView, lastFeedbackView)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(51)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(42)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        lastFeedbackView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview()
        }
        bottomContainerView.addSubview(submitButton)
        submitButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setStyles() {
        headerView.do {
            $0.setHeader(isFirstView: false, title: "소중한 피드백", buttonImage: "Xmark")
        }
        
        titleLabel.do {
            $0.text = "더 나은 텔링미가 될 수 있도록\n3가지 질문에 답해주세요!"
            $0.numberOfLines = 2
            $0.font = .fontNanum(.H5_Bold)
            $0.textColor = .Gray6
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = 40
            for (index, data) in viewModel.questions.enumerated() {
                let feedbackView = FeedbackView()
                feedbackView.setFeedbackQuestion(index: index+1, question: data)
                $0.addArrangedSubview(feedbackView)
            }
        }
        
        submitButton.do {
            $0.setText(text: "제출하기")
        }
    }
}
