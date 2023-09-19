//
//  MyPageTableViewCell.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import SnapKit
import Then

final class MyPageTableViewCell: UITableViewCell {
    
    private var isLogoutCell: Bool = false
    
    private let cellTitleLabel = UILabel()
    private let chevronImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setStyles()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isLogoutCell != false {
            setLogoutView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageTableViewCell {
    
    private func setStyles() {
        self.backgroundColor = .clear
        
        cellTitleLabel.do {
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Gray8
        }
        
        chevronImageView.do {
            $0.image = UIImage(named: "chevronNext")
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setLayout() {
        self.addSubviews(cellTitleLabel, chevronImageView)
        
        cellTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.centerY.equalToSuperview()
        }
        
        chevronImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(21)
            $0.centerY.equalToSuperview()
        }
    }
}

extension MyPageTableViewCell {
    private func setLogoutView() {
        chevronImageView.removeFromSuperview()
    }
}

extension MyPageTableViewCell {
    func configure(title: String, isLogoutCell: Bool = false) {
        cellTitleLabel.text = title
        self.isLogoutCell = isLogoutCell
    }
}
