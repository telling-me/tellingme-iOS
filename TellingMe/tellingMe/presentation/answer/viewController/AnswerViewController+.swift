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
    }
    
    func showCompletedModal() {
        self.showModal(id: "modalRegisterAnswer")
    }

    func emotionSelected(index: Int) {
        self.viewModel.emotion = index
        self.emotionView.isHidden = false
        self.emotionImageView.image = UIImage(named: self.viewModel.emotions[index].image)
        self.emotionLabel.text = self.viewModel.emotions[index].text
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
        if answerTextView.text.count > self.typeLimit {
            self.viewModel.isFull = true
        } else {
            self.viewModel.isFull = false
        }
        countTextLabel.text = String(answerTextView.text.count)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let utf8Char = text.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        if isBackSpace == -92 {
            return true
        }
        if self.viewModel.isFull {
            return false
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count > self.typeLimit {
        // 글자수 제한에 걸리면 마지막 글자를 삭제함.
            textView.text.removeLast()
            countTextLabel.text = "\(self.typeLimit)"
        }
    }
}
