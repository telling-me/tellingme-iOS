//
//  HomeSubDateView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

final class HomeSubDateView: BaseView {

    private let dateLabel = UILabel()
    
    override func setStyles() {
        self.backgroundColor = .Side200
        self.cornerRadius = 20
        
        dateLabel.do {
            $0.font = .fontNanum(.C1_Regular)
            $0.textColor = .Side500
            $0.textAlignment = .center
        }
    }
    
    override func setLayout() {
        self.addSubviews(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension HomeSubDateView {
    func setDate(date: [Int]) {
        if date.count < 3 {
            let dateString = Date().todayFormat()
            dateLabel.text = dateString
            return
        }
        
        let year = date[0]
        let month = date[1]
        let day = date[2]
        let dateString: String = "\(year)년 \(month)월 \(day)일"
        dateLabel.text = dateString
    }
}
