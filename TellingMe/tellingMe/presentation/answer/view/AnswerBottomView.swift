//
//  AnswerBottomView.swift
//  tellingMe
//
//  Created by 마경미 on 22.11.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class AnswerBottomView: BBaseView {
    private let countTextLabel = UILabel()
    private let limitTextLabel = UILabel()
    private let publicSwitchLabel = UILabel()
    private let publicSwitch = UISwitch()
    private let registerButton = UIButton()
    
    var countTextObservable: Binder<String?> {
        return countTextLabel.rx.text
    }
    
    var registerButtonTapObservable: Observable<Void> {
        return registerButton.rx.tap.asObservable()
    }
    
    var togglePublicSwitch: ControlProperty<Bool> {
        return publicSwitch.rx.isOn
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setStyles() {
        countTextLabel.do {
            $0.font = .fontNanum(.C1_Bold)
            $0.textColor = .Gray6
            $0.text = "0"
        }
        
        limitTextLabel.do {
            $0.font = .fontNanum(.C1_Bold)
            $0.textColor = .Gray6
            $0.text = "/ 300"
        }
        
        publicSwitchLabel.do {
            $0.font = .fontNanum(.C1_Regular)
            $0.textColor = .Gray8
            $0.text = AnswerStrings.publicLabel.stringValue
        }
        
        publicSwitch.do {
            $0.onTintColor = .Logo
        }
        
        registerButton.do {
            $0.titleLabel?.font = .fontNanum(.B1_Bold)
            $0.setTitleColor(.Logo, for: .normal)
            $0.setTitle(AnswerStrings.registerButton.stringValue, for: .normal)
        }
    }
    
    override func setLayout() {
        addSubviews(countTextLabel, limitTextLabel, publicSwitchLabel,
                    publicSwitch, registerButton)
        
        countTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
        }
        
        limitTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalTo(countTextLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        publicSwitchLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(25)
        }
        
        publicSwitch.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(publicSwitchLabel.snp.trailing).offset(10)
        }
        
        registerButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(25)
        }
    }
}
