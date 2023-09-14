//
//  FeedbackViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.09.23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class FeedbackViewController: UIViewController {
    private let viewModel = FeedbackViewModel()
    private let disposeBag = DisposeBag()
    
    private let headerView = InlineHeaderView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let infoButton = UIButton()
    private let subTitleLabel = UILabel()
    private let goodButton = SecondaryTextButton()
    private let badButton = TeritaryModifiedTextButton()
    public let bottomSheet = QuestionSheetView()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    private func toggleBottomSheet() {
        bottomSheet.isHidden.toggle()
        if bottomSheet.isHidden {
            bottomSheet.dismissAnimate()
        } else {
            bottomSheet.animate()
        }
        self.tabBarController?.tabBar.isHidden.toggle()

        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension FeedbackViewController {
    private func bindViewModel() {
        infoButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.toggleBottomSheet()
            })
            .disposed(by: disposeBag)
        bottomSheet.okButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.toggleBottomSheet()
            })
            .disposed(by: disposeBag)
        headerView.rightButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        goodButton.rx.tap
            .bind(onNext: { [weak self] _ in
                let vc = GoodFeedbackViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        badButton.rx.tap
            .bind(onNext: { [weak self] _ in
                let vc = BadFeedbackViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func setLayout() {
        view.addSubviews(headerView, imageView, titleLabel, infoButton, subTitleLabel, goodButton, badButton, bottomSheet)
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(66)
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(145)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.size.equalTo(120)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        infoButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(2)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.size.equalTo(32)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        goodButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(55)
        }
        badButton.snp.makeConstraints {
            $0.top.equalTo(goodButton.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(55)
        }
        bottomSheet.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setStyles() {
        view.backgroundColor = .Side100
        headerView.do {
            $0.setHeader(title: "소중한 피드백", buttonImage: "Xmark")
        }

        imageView.do {
            $0.image = UIImage(named: "Feedback")
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.text = "오늘 질문은 어땠나요?"
            $0.font = .fontNanum(.H5_Regular)
            $0.textColor = .Black
        }
        
        infoButton.do {
            $0.setImage(UIImage(systemName: "info.circle"), for: .normal)
            $0.tintColor = .Gray6
        }
        
        subTitleLabel.do {
            $0.text = "의견을 반영해서 더 좋은 질문을 드리고 싶어요!"
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray7
        }
        
        goodButton.do {
            $0.setText(text: "좋았어요!")
        }
        
        badButton.do {
            $0.setText(text: "아쉬워요..")
        }
        
        bottomSheet.do {
            $0.isHidden = true
        }
    }
}
