//
//  EmotionCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import UIKit

class EmotionCollectionViewCell: UICollectionViewCell {
    static let id = "imageCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        contentView.addSubview(imageView)
    }

    func setCell(with text: String) {
        imageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.image = UIImage(named: text)
    }

    func setAlpha() {
        imageView.alpha = 0.5
    }
    
    func setOrigin() {
        imageView.alpha = 1
    }
}
