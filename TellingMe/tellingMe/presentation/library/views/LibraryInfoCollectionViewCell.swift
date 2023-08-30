//
//  LibraryInfoCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 30.08.23.
//

import UIKit

class LibraryInfoCollectionViewCell: UICollectionViewCell {
    static let id = "libraryInfoCollectionViewCell"
    let imageView = UIImageView()
    let textLabel = UILabel()
    let equalLabel = UILabel()
    let stickView = UIView()
    let bottomView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setStyles()
    }
    
    func setData(emotion: Emotions) {
        imageView.image = UIImage(named: emotion.rawValue)
        textLabel.text = "  \(emotion.stringValue)  "
        stickView.backgroundColor = emotion.color
    }
}

extension LibraryInfoCollectionViewCell {
    func setLayout() {
        addSubviews(imageView, textLabel, equalLabel, stickView, bottomView)
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(imageView.snp.width)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(21)
        }
        textLabel.snp.makeConstraints {
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.height.equalTo(24)
            $0.top.equalTo(imageView.snp.bottom).offset(4)
        }
        equalLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(22)
            $0.centerY.equalToSuperview()
        }
        stickView.snp.makeConstraints {
            $0.leading.equalTo(equalLabel.snp.trailing).offset(23)
            $0.top.equalToSuperview().inset(6)
            $0.width.equalToSuperview().multipliedBy(0.12)
            $0.height.equalToSuperview().multipliedBy(0.66)
        }
        bottomView.snp.makeConstraints {
            $0.top.equalTo(stickView.snp.bottom)
            $0.centerX.equalTo(stickView.snp.centerX)
            $0.width.equalToSuperview().multipliedBy(0.32)
            $0.height.equalToSuperview().multipliedBy(0.125)
        }
    }

    func setStyles() {
        self.backgroundColor = .Side100
        textLabel.do {
            $0.backgroundColor = .Side200
            $0.font = .fontNanum(.B2_Bold)
            $0.textColor = .Gray6
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 4
        }
        equalLabel.do {
            $0.textColor = .Gray5
            $0.text = "="
        }
        stickView.do {
            $0.layer.cornerRadius = 4
        }
        bottomView.do {
            $0.backgroundColor = .Sub100
            $0.layer.cornerRadius = 4
        }
    }
}
