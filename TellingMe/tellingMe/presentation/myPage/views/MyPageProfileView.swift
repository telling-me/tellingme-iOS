//
//  MyPageProfileView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import SnapKit
import Then

final class MyPageProfileView: UIView {
    
    private var consecutiveDays: Int = 0
    private let cacheManager = ImageCacheManager.shared
    private let userDefaults = UserDefaults.standard
    
    private let userImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let consecutiveLabel = UILabel()
    private let premiumBadgeImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageProfileView {

    private func setStyles() {
        self.backgroundColor = .Side100
        
        userImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.backgroundColor = .Side200
        }
        
        userNameLabel.do {
            $0.font = .fontNanum(.H5_Regular)
            $0.textColor = .Black
            $0.numberOfLines = 1
        }
        
        consecutiveLabel.do {
            $0.font = .fontNanum(.C1_Bold)
            $0.textColor = .Gray5
        }
        
        premiumBadgeImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.layer.masksToBounds = true
        }
    }
    
    private func setLayout() {
        self.addSubviews(userImageView, userNameLabel, consecutiveLabel, premiumBadgeImageView)
        
        userImageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(userImageView.snp.height)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(15)
            $0.centerY.equalToSuperview().offset(-10)
            $0.width.lessThanOrEqualTo(170)
        }
        
        consecutiveLabel.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel.snp.leading)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(5)
        }
        
        premiumBadgeImageView.snp.makeConstraints {
            $0.centerY.equalTo(userNameLabel.snp.centerY)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(87)
            $0.height.equalTo(24)
        }
    }
}

extension MyPageProfileView {
    func setAttributedStringForConsecutiveLabel(day: Int) {
        let colorAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.Logo]
        if day == 0 {
            let text: String = "오늘도 진정한 나를 만나봐요!"
            let coloredText: String = "진정한 나"
            consecutiveLabel.attributedText = setPartialTextGreen(text: text, targetText: coloredText, attributes: colorAttributes)
        } else {
            let text: String = "연속 \(self.consecutiveDays)일째 답변 중!"
            consecutiveLabel.attributedText = setNumberTextGreen(text: text, attributes: colorAttributes)
        }
    }
    
    private func setNumberTextGreen(text: String, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        do {
            let regex = try NSRegularExpression(pattern: "\\d+")
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            for match in matches {
                print(match)
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

extension MyPageProfileView {
    func setUserName(newName: String, oldName: String = "") {
        if newName == oldName {
            return
        }

        if let userNameFromUserDefaults = userDefaults.string(forKey: StringLiterals.savedUserName) {
            userNameLabel.text = "\(userNameFromUserDefaults) 님"
        } else {
            userDefaults.set(newName, forKey: StringLiterals.savedUserName)
            userNameLabel.text = "\(newName) 님"
        }
    }
    
    func setConsecutiveDay(day: Int) {
        self.consecutiveDays = day
    }
    
    func setUserProfileImage(urlString: String) {
        self.userImageView.load(url: urlString)
    }
    
    func isUserPremiumUser(isPremium: Bool) {
        if isPremium != false {
            premiumBadgeImageView.image = UIImage(named: "PremiumBadge")
        }
    }
}
