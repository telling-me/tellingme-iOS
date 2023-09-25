//
//  FinishFeedbackViewController.swift
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

final class FinishFeedbackViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    private let headerView = InlineHeaderView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let captionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    deinit { }
}

extension FinishFeedbackViewController {
    private func bindViewModel() {
        headerView.rightButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func setLayout() {
        view.addSubviews(headerView, imageView, titleLabel, subTitleLabel, captionLabel)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(66)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(186)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        captionLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setStyles() {
        headerView.do {
            $0.setHeader(title: "소중한 피드백", buttonImage: "Xmark")
        }
        
        imageView.do {
            $0.image = UIImage(named: "Flag")
        }
        
        titleLabel.do {
            $0.text = "감사합니다!"
            $0.font = .fontNanum(.H5_Bold)
            $0.textColor = .Gray6
        }
        
        subTitleLabel.do {
            $0.text = "보내주신 피드백을 바탕으로\n더욱 발전하는 텔링미가 될게요!"
            $0.numberOfLines = 2
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray7
        }
        
        captionLabel.do {
            $0.text = "직접 질문을 제안하고 싶다\n마이페이지 -듀이의 질문 제작소를 찾아주세요!"
            $0.numberOfLines = 2
            $0.font = .fontNanum(.C1_Regular)
            $0.textColor = .Gray6
            $0.setBoldPart(text: "듀이의 질문 제작소", font: .fontNanum(.C1_Bold))
        }
    }
}
