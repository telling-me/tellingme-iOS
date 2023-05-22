//
//  ModifyAnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import UIKit

class ModifyAnswerViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var subQuestionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!

    @IBOutlet weak var emotionButton: UIButton!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!

    let viewModel = ModifyAnswerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        getQuestion()
        getAnswer()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        // 키보드 높이 계산
        let keyboardHeight = keyboardFrame.size.height
        bottomLayout.constant = keyboardHeight - view.safeAreaInsets.bottom
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        bottomLayout.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func clickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickComplete(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "modalRegisterAnswer") as? ModalViewController else {
            return
        }
        vc.delegeate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: false)
    }
}

extension ModifyAnswerViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let font = textView.font else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5

        let attributedText = NSMutableAttributedString(string: answerTextView.text)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        attributedText.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))

        answerTextView.attributedText = attributedText
    }
}

extension ModifyAnswerViewController: ModalActionDelegate {
    func clickCancel() {
    }

    // 답변 등록하기 버튼
    func clickOk() {
        self.modifyAnswer()
        self.navigationController?.popViewController(animated: true)
    }
}
