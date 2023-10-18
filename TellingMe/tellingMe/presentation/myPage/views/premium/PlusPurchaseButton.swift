//
//  PlusPurchaseButton.swift
//  tellingMe
//
//  Created by 마경미 on 18.10.23.
//

import UIKit

import RxCocoa
import SnapKit
import Then

final class PlusPurchaseButton: UIView {
    private let tapGesture = UITapGestureRecognizer()
    
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    lazy var tapObservable = tapGesture.rx.event.asObservable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlusPurchaseButton {
    private func setStyles() {
        self.layer.cornerRadius = 20
        self.backgroundColor = .Side200
        
        nameLabel.do {
            $0.font = .fontNanum(.H6_Regular)
            $0.textColor = .Gray8
        }
        
        priceLabel.do {
            $0.font = .fontNanum(.H6_Regular)
            $0.backgroundColor = .Logo
            $0.textColor = .white
            $0.textAlignment = .center
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 17.5
        }
    }
    
    private func setLayout() {
        self.addSubviews(nameLabel, priceLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(81)
            $0.height.equalTo(35)
        }
    }
}

extension PlusPurchaseButton {
    func setPlus(name: String, price: NSDecimalNumber) {
        nameLabel.text = name
        priceLabel.text = "\(price)원"
    }
}
