//
//  ContentWithTextView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/01.
//

import UIKit

import SnapKit
import Then

final class ContentWithTextView: UIView {
    
    private let textView = UITextView()
    private let likedButtonImageView = UIImageView()
    private let likedCountLabel = UILabel()
    private let likeStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentWithTextView {
    
    private func setStyles() {
        self.backgroundColor = .Side100
        
        textView.do {
            $0.backgroundColor = .Side100
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Black
            $0.delegate = self
            $0.isEditable = false
            $0.contentInset = UIEdgeInsets(top: 30, left: 20, bottom: 40, right: 20)
        }
        
        likedButtonImageView.do {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24)
            $0.image = UIImage(systemName: "heart.fill", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .Error300
            $0.contentMode = .scaleAspectFit
        }
        
        likedCountLabel.do {
            $0.font = .fontNanum(.C1_Bold)
            $0.textColor = .Gray7
        }
        
        likeStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 3
        }
    }
    
    private func setLayout() {
        likeStackView.addArrangedSubviews(likedButtonImageView, likedCountLabel)
        self.addSubviews(textView, likeStackView)
        
        textView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(116)
        }
        
        likeStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(35)
        }
    }
}

extension ContentWithTextView: UITextViewDelegate {
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
}

extension ContentWithTextView {
    func configure(data: ContentForAlarmModel) {
        textView.text = data.contentText
        likedCountLabel.text = "\(data.likeCount)"
    }
}
