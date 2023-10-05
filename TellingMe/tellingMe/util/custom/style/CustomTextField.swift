//
//  Input.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import Foundation
import UIKit

import RxSwift
import SnapKit
import Then

final class CustomTextField: UIView {
    private let disposeBag = DisposeBag()
    var inputTextField: UITextField = {
       let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.borderStyle = .none
        input.textColor = UIColor(named: "Black")
        input.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        input.backgroundColor = .clear
        input.clearButtonMode = .whileEditing
        input.returnKeyType = .done
        return input
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "Side200")
        self.cornerRadius = 18
        addSubview(inputTextField)
        inputTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        inputTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }

    func setDisalbe() {
        self.backgroundColor = UIColor(named: "Gray1")
        self.inputTextField.text = nil
        inputTextField.isUserInteractionEnabled = false
        inputTextField.placeholder = "기타 선택 후 입력"
    }

    func setAble() {
        self.backgroundColor = UIColor(named: "Side200")
        self.inputTextField.placeholder = "직접 입력"
        inputTextField.isUserInteractionEnabled = true
    }
    
    func setPlaceholder(text: String) {
        self.inputTextField.placeholder = text
    }

    func setText(text: String) {
        self.inputTextField.text = text
    }

    func getText() -> String? {
        return self.inputTextField.text
    }

    func hiddenKeyboard() {
        self.inputTextField.resignFirstResponder()
    }

    func setInputKeyobardStyle() {
        inputTextField.keyboardType = .numberPad
    }
}

extension CustomTextField {
    func bindViewModel() {
        inputTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                inputTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }

    func setBirthInput() {
        inputTextField.keyboardType = .numberPad
    }
}
