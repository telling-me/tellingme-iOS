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

class SignUpBaseViewController: BaseViewController {
    let titleLabel = UILabel()
    let infoButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setStyles()
    }
    
    deinit {
        print("SingUpBaseViewController Deinited")
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
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
    }
    
    private func setStyles() {
        titleLabel.do {
            $0.font = .fontNanum(.H4_Regular)
            $0.textColor = .Black
        }
        
        infoButton.do {
            $0.isHidden = true
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
