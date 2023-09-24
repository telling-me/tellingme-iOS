//
//  CustomAlertView.swift
//  tellingMe
//
//  Created by 마경미 on 24.09.23.
//

import UIKit

import RxSwift
import SnapKit
import Then

class CustomAlertView: UIView {
    private let backgroundView: UIView = UIView()
    private let alertView: UIView = UIView()
    private let alertTextLabel: UILabel = UILabel()
    private let okButton: SecondaryTextButton = SecondaryTextButton()
    
    private let disposeBag = DisposeBag()

    let buttonTapObserver = PublishSubject<Void>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAlertText(text: String) {
        alertTextLabel.text = text
    }
    
    func showAlert() {
        alertView.isHidden = false
        alertView.snp.updateConstraints {
            $0.centerY.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func dismissAlert() {
        alertView.isHidden = false
        alertView.snp.updateConstraints {
            $0.centerY.equalTo(self.snp.bottom)
        }

        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        })
    }
}

extension CustomAlertView {
    private func bindViewModel() {
        okButton.rx.tap
            .bind(to: buttonTapObserver)
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        addSubviews(alertView)
        alertView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.centerY.equalTo(self.snp.bottom)
        }
        alertView.addSubviews(alertTextLabel, okButton)
        alertTextLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(30)
        }
        okButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(20)
            $0.top.equalTo(alertTextLabel.snp.bottom).offset(28)
        }
    }
    
    private func setStyles() {
        backgroundColor = .AlphaBlackColor
        alertView.do {
            $0.backgroundColor = .Side100
            $0.layer.cornerRadius = 20
            $0.isHidden = true
        }
        alertTextLabel.do {
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Black
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        okButton.do {
            $0.setText(text: "확인")
        }
    }
}
