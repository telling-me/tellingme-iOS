//
//  PremiumInformationHeaderView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/11.
//

import UIKit

import SnapKit
import Then

final class PremiumInformationHeaderView: UICollectionReusableView {
    
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
        setAttributedStringForConsecutiveLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PremiumInformationHeaderView {
    
    private func setStyles() {
        self.backgroundColor = .clear
        
        descriptionLabel.do {
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Black
            $0.numberOfLines = 2
        }
    }
    
    private func setLayout() {
        self.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setAttributedStringForConsecutiveLabel() {
        let colorAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.Logo]
        let text = """
                   텔링미 플러스를 구독한 분들께
                   드리는 5가지 특별한 혜택
                   """
        let coloredText = "5가지 특별한 혜택"
        descriptionLabel.attributedText = setPartialTextGreen(text: text, targetText: coloredText, attributes: colorAttributes)
    }
}

extension PremiumInformationHeaderView {
    private func setPartialTextGreen(text: String, targetText: String, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        if let range = text.range(of: targetText) {
            let newNSRange = NSRange(range, in: text)
            attributedString.addAttributes(attributes, range: newNSRange)
        }
        return attributedString
    }
}
