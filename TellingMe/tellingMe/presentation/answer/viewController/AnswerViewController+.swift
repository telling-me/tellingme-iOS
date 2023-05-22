//
//  AnswerViewController+.swift
//  tellingMe
//
//  Created by 마경미 on 21.05.23.
//

import UIKit
import Foundation

extension AnswerViewController: EmotionDelegate {
    func emotionViewCancel() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AnswerViewController: UITextViewDelegate {
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

extension AnswerViewController: ModalActionDelegate {
    func clickCancel() {
    }

    // 답변 등록하기 버튼
    func clickOk() {
        self.postAnswer()
        self.navigationController?.popViewController(animated: true)
    }
}
