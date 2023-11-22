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

final class AnswerBottomView: UIView {
    private let countTextLabel = UILabel()
    private let limitTextLabel = UILabel()
    private let publicSwitchLabel = UILabel()
    private let publicSwitch = UISwitch()
    private let registerButton = UIButton()
    
    var registerButtonTapped: Observable<Void> {
        return registerButton.rx.tap.asObservable()
    }
    
    let viewModel: AnswerViewModel
    
    init(viewModel: AnswerViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnswerBottomView {
    private func setStyles() {
        countTextLabel.do {
            $0.font = .fontNanum(.C1_Bold)
        }
        
        limitTextLabel.do {
            $0.font = .fontNanum(.C1_Bold)
        }
        
        publicSwitchLabel.do {
            $0.font = .fontNanum(.C1_Regular)
            $0.text = AnswerStrings.publicLabel.stringValue
        }
        
        publicSwitch.do {
            $0.tintColor = .Logo
        }
        
        registerButton.do {
            $0.setTitle(AnswerStrings.registerButton.stringValue, for: .normal)
        }
    }
    
    private func setLayout() {
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
            $0.bottom.equalToSuperview().inset(10)
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
