//
//  NickNameViewController.swift
//  tellingMe
//
//  Created by 마경미 on 01.10.23.
//

import UIKit

import SnapKit
import Then

class NickNameViewController: SignUpBaseViewController {
    private var inputBox = Input()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
}

extension NickNameViewController {
    private func bindViewModel() {
        
    }
    
    private func setLayout() {
        view.addSubview(inputBox)
        
        inputBox.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(110)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
    }
    
    private func setStyles() {
        titleLabel.do {
            $0.text = "닉네임을 정해주세요"
        }
        
        inputBox.do {
            $0.inputTextField.delegate = self
        }
    }
}

extension NickNameViewController {
    private func checkNickname() {
        if let text = inputBox.inputTextField.text {
            var isWord = true
//            for word in viewModel.badwords where text.contains(word) {
//                showToast(message: "사용할 수 없는 닉네임입니다")
//                isWord = false
//                break
//            }
            if isWord {
                
            }
        }
    }
}

extension NickNameViewController: UITextFieldDelegate {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let utf8Char = string.cString(using: .utf8)
            let isBackSpace = strcmp(utf8Char, "\\b")

            if isBackSpace == -92 || (string.hasCharacters()) {
                return true
            }
            return false
        }
}
