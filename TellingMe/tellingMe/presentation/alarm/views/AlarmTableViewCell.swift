//
//  AlarmTableViewCell.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import UIKit

import SnapKit
import Then

final class AlarmTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let titleStackView = UIStackView()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlarmTableViewCell {
    private func setStyles() {
        self.backgroundColor = UIColor(named: "Side100")
        
        titleLabel.do {
            $0.font = UIFont(name: "NanumSquareRoundOTFB", size: 14)
            $0.textColor = UIColor(named: "Gray8")
            $0.numberOfLines = 1
        }
        
        subTitleLabel.do {
            $0.font
        }
    }
    
    private func setLayout() {
        self.addSubviews()
        
    }
}
