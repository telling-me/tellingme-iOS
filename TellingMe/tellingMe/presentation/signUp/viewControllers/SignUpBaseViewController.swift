//
//  SignUpBaseViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.09.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

// base viewcontroller 상속받기
class SignUpBaseViewController: UIViewController {
    private let titleLabel = UILabel()
    private let infoButton = UIButton()
    
    var buttonTapObservable: ControlEvent<Void> {
        return infoButton.rx.tap
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setStyles()
    }
}

extension SignUpBaseViewController {
    private func setLayout() {
        view.addSubviews(titleLabel, infoButton)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(27)
        }
        
        infoButton.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel).offset(4)
        }
    }
    
    private func setStyles() {
        titleLabel.do {
            $0.font = .fontNanum(.H4_Regular)
            $0.textColor = .Black
        }
        
        infoButton.do {
            $0.setImage(UIImage(named: "Info"), for: .normal)
        }
    }
}

extension SignUpBaseViewController {
    func setTitle(text: String, isInfoButtonHidden: Bool = true) {
        titleLabel.text = text
        infoButton.isHidden = isInfoButtonHidden
    }
}
