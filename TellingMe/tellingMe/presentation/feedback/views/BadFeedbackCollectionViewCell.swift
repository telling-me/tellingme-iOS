//
//  BadFeedbackCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 14.09.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class BadFeedbackCollectionViewCell: UICollectionViewCell {
    static let id = "badFeedbackCollectionViewCell"
    
    private let containerView = UIView()
    private let label = UILabel()
    
    override var isSelected: Bool {
        didSet {
            isSelected ? setSelected() : setDefault()
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
    
    deinit {
        print("BadFeedbackCollectionViewCell Deinit")
    }
}

extension BadFeedbackCollectionViewCell {
    private func setLayout() {
        addSubview(containerView)
        containerView.addSubview(label)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        label.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setStyles() {
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
}

extension BadFeedbackCollectionViewCell {
    private func setDefault() {
        containerView.backgroundColor = .Side200
    }
    
    private func setSelected() {
        containerView.backgroundColor = .Side300
    }
}

extension BadFeedbackCollectionViewCell {
    func setCell(text: String) {
        label.text = text
    }
}
