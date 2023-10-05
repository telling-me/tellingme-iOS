//
//  BottoinInfoView.swift
//  tellingMe
//
//  Created by 마경미 on 03.10.23.
//

import UIKit

import RxCocoa
import SnapKit
import Then

final class BottomInfoView: UIView {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let captionLabel = UILabel()
    private let button = SecondaryTextButton()
    
    var buttonTapObservable: ControlEvent<Void> {
        return button.rx.tap
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomInfoView {
    private func setLayout() {
        addSubview(containerView)
        containerView.addSubviews(titleLabel, captionLabel, button)
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(205)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17)
        }
        
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(captionLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(55)
        }
    }
    
    private func setStyles() {
        backgroundColor = .AlphaBlackColor
        
        containerView.do {
            $0.backgroundColor = .Side100
            $0.layer.cornerRadius = 28
        }

        titleLabel.do {
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Black
            $0.textAlignment = .center
        }
        
        captionLabel.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray5
            $0.textAlignment = .center
        }
        
        button.do {
            $0.setText(text: "확인")
        }
    }
}

extension BottomInfoView {
    func setTitle(currentIndex: Int) {
        if currentIndex == 3 {
            titleLabel.text = "직업이 비슷한 사람들과 먼저 소통해요."
            captionLabel.text = "설정에서 직업을 변경할 수 있어요."
        } else {
            titleLabel.text = "고민이 비슷한 사람들과 먼저 소통해요."
            captionLabel.text = "설정에서 고민을 변경할 수 있어요."
        }
    }
    
    func animateView() {
        containerView.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }
}
