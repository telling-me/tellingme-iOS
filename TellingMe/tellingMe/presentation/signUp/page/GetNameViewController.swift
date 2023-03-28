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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let text = textField.text
        if text == "" {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        self.textField.resignFirstResponder()
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPageWithIndex(index: 2)
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
        var text = textField.text
        if text == "" {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        self.textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        return true
    }
}
