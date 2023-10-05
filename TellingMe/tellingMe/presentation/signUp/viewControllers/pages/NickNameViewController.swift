//
//  NickNameViewController.swift
//  tellingMe
//
//  Created by 마경미 on 01.10.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class NickNameViewController: SignUpBaseViewController {
    private let viewModel: SignUpViewModel
    private let disposeBag = DisposeBag()
    
    private var inputBox = CustomTextField()
    private var captionLabel = UILabel()
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.checkNicknameInputed()
    }
    
    deinit {
        print("NicknameViewController Deinited")
    }
}

extension NickNameViewController {
    private func bindViewModel() {
        inputBox.inputTextField.rx.controlEvent(.editingChanged)
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self,
                      let text = self.inputBox.inputTextField.text else {
                    return
                }
                
                if text.count > 8 {
                    self.inputBox.inputTextField.text = String(text.prefix(8))
                    self.inputBox.hiddenKeyboard()
                }
                viewModel.checkNicknameInputed()
            })
            .disposed(by: disposeBag)
        
        inputBox.inputTextField.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                viewModel.checkNicknameInputed()
            })
            .disposed(by: disposeBag)
        
        inputBox.inputTextField.rx.text
            .orEmpty
            .bind(to: viewModel.inputs.nicknameTextRelay)
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubviews(inputBox, captionLabel)
        
        inputBox.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(110)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(inputBox.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(35)
        }
    }
    
    private func setStyles() {
        titleLabel.do {
            $0.text = "닉네임을 정해주세요"
        }
        
//        inputBox.do {
//            $0.inputTextField.delegate = self
//        }
        
        captionLabel.do {
            $0.text = "영문, 숫자, 띄어쓰기, 특수문자 불가"
            $0.textColor = .Gray7
            $0.font = .fontNanum(.C1_Regular)
        }
    }
}

//extension NickNameViewController: UITextFieldDelegate {
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            let utf8Char = string.cString(using: .utf8)
//            let isBackSpace = strcmp(utf8Char, "\\b")
//
//            if isBackSpace == -92 || (string.checkOnlyKoreanCharacters()) {
//                return true
//            }
//            return false
//        }
//}
