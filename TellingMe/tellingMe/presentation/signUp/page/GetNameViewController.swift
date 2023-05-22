//
//  GetNameViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class GetNameViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var prevButton: SecondaryIconButton!
    @IBOutlet weak var nextButton: SecondaryIconButton!
    @IBOutlet weak var textFieldView: UIView!
    let viewModel = GetNameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.setImage(image: "ArrowLeft")
        nextButton.isEnabled = false
        nextButton.setImage(image: "ArrowRight")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.offKeyboard()
    }

    func offKeyboard() {
        guard let text = textField.text else { nextButton.isEnabled = false
            return
        }
        if text.count <= 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        self.textField.resignFirstResponder()
    }

    func setOriginal() {
        textFieldView.backgroundColor = UIColor(named: "Side200")
    }

    @IBAction func nextAction(_ sender: UIButton) {
        if let text = textField.text {
            var isWord = true
            for word in viewModel.badwords where text.contains(word) {
                showToast(message: "사용할 수 없는 닉네임입니다")
                isWord = false
                break
            }
            if isWord {
                self.checkNickname(nickname: text)
            }
        }
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPage()
    }
}

extension GetNameViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.setOriginal()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.offKeyboard()
        return true
    }
}
