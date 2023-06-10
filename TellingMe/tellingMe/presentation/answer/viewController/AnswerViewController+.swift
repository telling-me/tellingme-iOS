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

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 이전 글자 - 선택된 글자 + 새로운 글자(대체될 글자)
        let newLength = textView.text.count - range.length + text.count
        let koreanMaxCount = 500 + 1
        // 글자수가 초과 된 경우 or 초과되지 않은 경우
        if newLength > koreanMaxCount {
            let overflow = newLength - koreanMaxCount // 초과된 글자수
            if text.count < overflow {
                self.countTextLabel.text = String(newLength)
                return true
            }
            let index = text.index(text.endIndex, offsetBy: -overflow)
            let newText = text[..<index]
            guard let startPosition = textView.position(from: textView.beginningOfDocument, offset: range.location) else { return false }
            guard let endPosition = textView.position(from: textView.beginningOfDocument, offset: NSMaxRange(range)) else { return false }
            guard let textRange = textView.textRange(from: startPosition, to: endPosition) else { return false }

            textView.replace(textRange, withText: String(newText))
            return false
        }
        self.countTextLabel.text = String(newLength)
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count > 300 {
        // 글자수 제한에 걸리면 마지막 글자를 삭제함.
            textView.text.removeLast()
            countTextLabel.text = "\(300)"
        }
    }
}
