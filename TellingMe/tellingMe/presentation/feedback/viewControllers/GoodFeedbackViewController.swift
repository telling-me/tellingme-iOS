//
//  GoodFeedbackViewController.swift
//  tellingMe
//
//  Created by 마경미 on 12.09.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class GoodFeedbackViewController: BaseViewController {
    private let viewModel = GoodFeedbackViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let headerView = InlineHeaderView()
    private let scrollView = UIScrollView()
    private let scrollContainerView = UIView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let lastFeedbackView = OtherFeedbackView(frame: .zero, index: 4)
    private let bottomContainerView = UIView()
    private let submitButton = SecondaryTextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            
            guard let view = view as? FeedbackView,
                  index < viewModel.inputs.sliderObservables.count else {
                return
            }
            view.sliderObservable
                .bind(to: viewModel.inputs.sliderObservables[index])
                .disposed(by: disposeBag)
        }
    }
    
    override func bindViewModel() {
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
            .throttle(.seconds(3), latest: false, scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.postFeedback()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.successSubject
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.pushToFinishFeedbackViewController()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.showToastSubject
            .bind(onNext: { [weak self] message in
                guard let self = self else { return }
                self.showToast(message: message)
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { [weak self] notification in
                guard let self = self else { return }
                let offsetY = stackView.frame.maxY - 55
                self.scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func setLayout() {
        view.addSubviews(headerView, scrollView, bottomContainerView)
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.addSubviews(titleLabel, stackView, lastFeedbackView)
        bottomContainerView.addSubview(submitButton)
        
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
        
        scrollContainerView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
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
        
        submitButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setStyles() {
        headerView.do {
            $0.setHeader(isFirstView: false, title: "소중한 피드백", buttonImage: "Xmark")
        }
        
        scrollView.do {
            $0.keyboardDismissMode = .onDrag
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
    
    deinit {
        print("GoodFeedbackViewController Deinit")
    }
}

extension GoodFeedbackViewController {
    private func pushToFinishFeedbackViewController() {
        let vc = FinishFeedbackViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
