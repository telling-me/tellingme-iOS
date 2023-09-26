//
//  CustomAlertView.swift
//  tellingMe
//
//  Created by 마경미 on 24.09.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class CustomAlertView: UIView {
    private let disposeBag = DisposeBag()
    
    private let backgroundView = UIView()
    private let alertView = UIView()
    private let alertTextLabel = UILabel()
    private let okButton = SecondaryTextButton()
    
    let buttonTapObserver = PublishSubject<Void>()
    
    init(frame: CGRect, message: String) {
        super.init(frame: frame)
        bindViewModel()
        setLayout()
        setStyles()
        setAlertText(text: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("CustomAlertView Deinit")
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
        alertView.addSubviews(alertTextLabel, okButton)
        
        alertView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.centerY.equalToSuperview().offset(300)
        }
        
        alertTextLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(30)
        }
        
        okButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(20)
            $0.top.equalTo(alertTextLabel.snp.bottom).offset(28)
            $0.height.equalTo(55)
        }
    }
    
    private func setStyles() {
        backgroundColor = .AlphaBlackColor
        
        alertView.do {
            $0.backgroundColor = .Side100
            $0.layer.cornerRadius = 20
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

extension CustomAlertView {
    private func setAlertText(text: String) {
        alertTextLabel.text = text
    }
}

extension CustomAlertView {
    func showAlert() {
        self.alertView.snp.updateConstraints {
            $0.centerY.equalToSuperview().offset(0)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.alertView.layoutIfNeeded()
        })
    }
    
    func dismissAlert() {
    }
}
