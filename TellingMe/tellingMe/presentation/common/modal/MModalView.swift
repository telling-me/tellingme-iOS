//
//  MModalView.swift
//  tellingMe
//
//  Created by 마경미 on 06.12.23.
//

import UIKit

import RxSwift
import SnapKit
import Then

final class MModalView: BBaseView {
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let leftButton = TeritaryTextButton()
    private let rightButton = SecondaryTextButton()
    
    var leftButtonTapObservable: Observable<Void> {
        return leftButton.rx.tap.asObservable()
    }
    
    var rightButtonTapObservable: Observable<Void> {
        return rightButton.rx.tap.asObservable()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setStyles() {
        backgroundColor = .AlphaBlackColor
        
        contentView.do {
            $0.backgroundColor = .Side100
            $0.layer.cornerRadius = 20
        }
        
        titleLabel.do {
            $0.font = .fontNanum(.B1_Regular)
            $0.textAlignment = .center
            $0.textColor = .Black
        }
        
        subTitleLabel.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textAlignment = .center
            $0.textColor = .Gray7
        }
        
        buttonStackView.do {
            $0.distribution = .fillEqually
            $0.spacing = 15
        }
    }
    
    override func setLayout() {
        addSubview(contentView)
        contentView.addSubviews(titleLabel, subTitleLabel, buttonStackView)
        buttonStackView.addArrangedSubviews(leftButton, rightButton)
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(17)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(16)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

extension MModalView {
    func setModalButton(leftButtonTitle: String, rightButtonTitle: String) {
        leftButton.setText(text: leftButtonTitle)
        rightButton.setText(text: rightButtonTitle)
    }
    
    func setModalTitle(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    func showOpenAnimation() {
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.contentView.transform = .identity
        }
    }
}
