//
//  InlineHeaderView.swift
//  tellingMe
//
//  Created by 마경미 on 26.08.23.
//

import Foundation
import UIKit

final class InlineHeaderView: UIView {
    private let title = Headline6Bold()
    let leftButton = UIButton()
    let rightButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }
}

extension InlineHeaderView {
    private func setLayout() {
       addSubviews(leftButton, title, rightButton)
        leftButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(32)
        }
        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(21)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
    }
    
    private func setStyles() {
        leftButton.do {
            $0.setImage(UIImage(named: "ArrowLeft"), for: .normal)
        }
        
        title.do {
            $0.font = .fontNanum(.H6_Bold)
            $0.textColor = .Gray6
        }
    }
}

extension InlineHeaderView {
    func setHeader(isFirstView: Bool = true, title: String, buttonImage: String? = nil) {
        if isFirstView {
            leftButton.isHidden = true
        } else {
            leftButton.isHidden = false
        }
        if let buttonImage = buttonImage {
            self.title.text = title
            rightButton.isHidden = false
            rightButton.setImage(UIImage(named: buttonImage), for: .normal)
        } else {
            self.title.text = title
            rightButton.isHidden = true

        }
    }
}
