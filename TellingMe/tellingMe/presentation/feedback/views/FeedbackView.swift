//
//  FeedbackView.swift
//  tellingMe
//
//  Created by 마경미 on 11.09.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class FeedbackView: UIView {
    private let disposeBag = DisposeBag()

    private let numberLabel = UILabel()
    private let questionLabel = UILabel()
    private let stepView = UIStackView()
    private let agreeLabel = UILabel()
    private let badLabel = UILabel()
    private let slider = UISlider()
    
    lazy var sliderObservable: ControlProperty<Float> = slider.rx.value

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedbackView {
    private func bindViewModel() {
        slider.rx.value
            .bind(onNext: { [weak self] value in
                self?.handleSliderValueChange(value: value)
            })
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        addSubviews(numberLabel, questionLabel, slider, stepView, badLabel, agreeLabel)
        
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
        
        stepView.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(10)
            $0.height.equalTo(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        badLabel.snp.makeConstraints {
            $0.top.equalTo(agreeLabel.snp.top)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(28)
        }
        
        agreeLabel.snp.makeConstraints {
            $0.top.equalTo(stepView.snp.bottom).offset(4)
            $0.leading.bottom.equalToSuperview()
            $0.height.equalTo(28)
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
            $0.numberOfLines = 2
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Gray8
        }
        
        slider.do {
            $0.maximumValue = 5
            $0.minimumValue = 1
            $0.value = 3
            $0.isContinuous = false
            $0.cornerRadius = 5
            $0.setThumbImage(UIImage(named: "Thumb"), for: .normal)
            $0.setMinimumTrackImage(UIImage(named: "Range"), for: .normal)
            $0.setMaximumTrackImage(UIImage(named: "Track"), for: .normal)
        }
        
        stepView.do {
            $0.distribution = .fillEqually
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            $0.spacing = (appDelegate.deviceWidth - 66) / 5 - 12
            for _ in 0...4 {
                let stick = StickView()
                $0.addArrangedSubview(stick)
            }
        }
        
        badLabel.do {
            $0.text = "그렇지\n않다"
            $0.numberOfLines = 2
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

extension FeedbackView {
    private func handleSliderValueChange(value: Float) {
        let roundedValue = round(value)
        slider.value = roundedValue
    }
}

extension FeedbackView {
    func setFeedbackQuestion(index: Int, question: String) {
        numberLabel.text = "\(index)"
        questionLabel.text = question
        questionLabel.setColorPart(text: "*", color: .Error400)
    }
}
