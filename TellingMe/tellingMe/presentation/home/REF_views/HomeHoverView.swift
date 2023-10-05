//
//  HomeHoverView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

final class HomeHoverView: BBaseView {

    private let titleLabel = UILabel()
    
    override func setStyles() {
        self.setRoundShadowWith(backgroundColor: .Side100, shadowColor: .black, radius: 8,
                                shadowRadius: 12, shadowOpacity: 0.1, xShadowOffset: 0, yShadowOffset: 4)
        
        titleLabel.do {
            $0.textColor = .Gray5
            $0.font = .fontNanum(.C1_Bold)
            $0.textAlignment = .center
            $0.text = "-"
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
    }
}

extension HomeHoverView {
    
    private func setNumberTextGreen(text: String, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        do {
            let regex = try NSRegularExpression(pattern: "\\d+")
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            for match in matches {
                let numberRange = match.range(at: 0)
                attributedString.addAttributes(attributes, range: numberRange)
                break
            }
        } catch let error {
            print("Error Regex: \(error)")
        }
        return attributedString
    }
    
    private func setPartialTextGreen(text: String, targetText: String, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        if let range = text.range(of: targetText) {
            let newNSRange = NSRange(range, in: text)
            attributedString.addAttributes(attributes, range: newNSRange)
        }
        return attributedString
    }
}

extension HomeHoverView {
    
    func setConsecutiveLabel(day: Int) {
        let colorAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.Logo]
        if day == 0 {
            let text: String = "오늘도 진정한 나를 만나봐요!"
            let coloredText: String = "진정한 나"
            titleLabel.attributedText = setPartialTextGreen(text: text, targetText: coloredText, attributes: colorAttributes)
        } else {
            let text: String = "연속 \(day)일째 답변 중!"
            titleLabel.attributedText = setNumberTextGreen(text: text, attributes: colorAttributes)
        }
    }
}
