//
//  BadFeedbackCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 14.09.23.
//

import UIKit
import SnapKit
import Then

class BadFeedbackCollectionViewCell: UICollectionViewCell {
    static let id = "badFeedbackCollectionViewCell"
    let containerView = UIView()
    let label = UILabel()
    
    override var isSelected: Bool {
        didSet {
            isSelected ? setSelected() :setDefault()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(text: String) {
        label.text = text
    }
}

extension BadFeedbackCollectionViewCell {
    func setLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.addSubview(label)
        label.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setStyles() {
        backgroundColor = .Side100
        containerView.do {
            $0.backgroundColor = .Side200
            $0.layer.cornerRadius = 16
        }
        
        label.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray7
        }
    }
    
    func setDefault() {
        containerView.backgroundColor = .Side200
    }
    
    func setSelected() {
        containerView.backgroundColor = .Side300
    }
}
