//
//  SharingToInstagramTableViewCell.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/12.
//

import UIKit

import SnapKit
import Then

final class SharingToInstagramTableViewCell: UITableViewCell {

    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SharingToInstagramTableViewCell {
    
    private func setStyles() {
        self.backgroundColor = .Side100
        self.selectionStyle = .none
        
        titleLabel.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray8
        }
    }
    
    private func setLayout() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(28)
            $0.centerY.equalToSuperview()
        }
    }
}

extension SharingToInstagramTableViewCell {
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
