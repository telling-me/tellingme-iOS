//
//  GetNameViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class GetNameViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    let viewModel = GetNameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
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

    func setWarning() {
        textField.backgroundColor = UIColor(named: "Error100")
    }

    @IBAction func nextAction(_ sender: UIButton) {
        if let text = textField.text {
            var isBadWord = false
            for word in viewModel.badwords {
                if text.contains(word) {
                    setWarning()
                    isBadWord = true
                    break
                }
            }
            if !isBadWord {
                self.checkNickname(nickname: text)
            }
        }
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 0)
        self.dismiss(animated: true, completion: nil)
    }
}

extension GetNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        guard let text = textField.text else { return false }
        if isBackSpace == -92 || (string.hasCharacters() && text.count <= 8) {
            return true
        }
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.offKeyboard()
//        self.dismiss(animated: true, completion: nil)
        return true
    }
}
