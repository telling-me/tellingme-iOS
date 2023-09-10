//
//  OnBoardingCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 10.09.23.
//

import UIKit

final class OnBoardingCollectionViewCell: UICollectionViewCell {
    static let id = "onBoardingCollectionViewCell"
    
    private let title = UILabel()
    private let subTitle = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setData(data: OnBoarding) {
        title.text = data.title
        let attributedString = NSMutableAttributedString(string: data.title)
        let range = (data.title as NSString).range(of: data.highLightTitle)
        attributedString.addAttribute(.font, value: UIFont.fontNanum(.H5_Bold), range: range)
        title.attributedText = attributedString
        subTitle.text = data.subTitle
        imageView.image = UIImage(named: data.image)
        
    }
}

extension OnBoardingCollectionViewCell {
    private func setLayout() {
        addSubviews(title, subTitle, imageView)
        title.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(36)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.height.equalTo(36)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
    }
    
    private func setStyles() {
        self.backgroundColor = .Side100
    
        title.do {
            $0.numberOfLines = 2
            $0.font = .fontNanum(.H5_Regular)
            $0.textColor = .Logo
            $0.textAlignment = .center
        }
        
        subTitle.do {
            $0.numberOfLines = 2
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray8
            $0.textAlignment = .center
        }
        
        imageView.do {
            $0.contentMode = .center
        }
    }
}
