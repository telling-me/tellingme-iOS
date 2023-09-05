//
//  WeekView.swift
//  tellingMe
//
//  Created by 마경미 on 27.08.23.
//

import UIKit
import SnapKit

class WeekHeaderView: UICollectionReusableView {
    static let id = "weekHeaderView"
    let weekLabel = CaptionLabelBold()
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setData(week: Int) {
        countLabel.text = "\(week)"
    }
}

extension WeekHeaderView {
    func setLayout() {
        addSubviews(weekLabel, countLabel)

        weekLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(weekLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    func setStyles() {
        self.backgroundColor = .Side100
        weekLabel.do {
            $0.text = "week"
            $0.textColor = .Side500
        }
        
        countLabel.do {
            $0.backgroundColor = .Side200
            $0.textColor = .Side500
            $0.textAlignment = .center
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
        }
    }
}
