//
//  NickNameInputViewController.swift
//  tellingMe
//
//  Created by 마경미 on 19.05.23.
//

import UIKit

protocol SendNicknameDelegate: AnyObject {
    func nicknameisEmpty()
    func nicknameisNotEmpty()
}

class NickNameInputViewController: UIViewController {
    let input = Input()
    weak var delegate: SendNicknameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(input)
        input.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        input.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        input.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        input.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        input.inputBox.delegate = self
        // Do any additional setup after loading the view.
    }

    func offKeyboard() {
        input.hiddenKeyboard()
    }

    func setText(text: String?) {
        input.inputBox.text = text
    }
//
    func getText() -> String? {
        return input.inputBox.text
    }
}

extension NickNameInputViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.setOriginal()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.offKeyboard()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            self.delegate?.nicknameisEmpty()
        } else {
            self.delegate?.nicknameisNotEmpty()
        }
    }
}
