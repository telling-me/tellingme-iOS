//
//  AnswerTextView.swift
//  tellingMe
//
//  Created by 마경미 on 07.08.23.
//

import Foundation
import UIKit

class AnswerTextView: UIView {
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "NanumSquareRoundOTFR", size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        self.backgroundColor = UIColor(named: "Side100")
        textView.backgroundColor = UIColor(named: "Side100")

        textView.delegate = self

        addSubview(textView)
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 36).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42).isActive = true
    }

    func setTextWithNoChange(text: String) {
        textView.isEditable = false
        textView.text = text
    }

    func setTextWithChange(text: String) {
        textView.isEditable = true
        textView.text = text
    }
}

extension AnswerTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let font = textView.font else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5

        let attributedText = NSMutableAttributedString(string: self.textView.text)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        attributedText.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))

        self.textView.attributedText = attributedText
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let utf8Char = text.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        if isBackSpace == -92 {
            return true
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
    }
}
