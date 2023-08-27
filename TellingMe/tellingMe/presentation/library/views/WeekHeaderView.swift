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

        weekLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(countLabel.snp.top).offset(2)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setStyles() {
        weekLabel.do {
            $0.text = "week"
            $0.textColor = .red
        }
        
        countLabel.do {
            $0.backgroundColor = .black
            $0.textColor = .red
        }
    }
}
