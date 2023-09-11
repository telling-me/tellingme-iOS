//
//  PremiumInformationCollectionViewCell.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/10.
//

import UIKit

import SnapKit
import Then

final class PremiumInformationCollectionViewCell: UICollectionViewCell {
    
    private let premiumInfoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        premiumInfoImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PremiumInformationCollectionViewCell {
    
    private func setStyles() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        self.cornerRadius = 16
        
        premiumInfoImageView.do {
            $0.contentMode = .scaleAspectFill
        }
    }
    
    private func setLayout() {
        self.addSubview(premiumInfoImageView)
        
        premiumInfoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PremiumInformationCollectionViewCell {
    func confiugre(imageName: String) {
        premiumInfoImageView.image = UIImage(named: imageName)
    }
}
