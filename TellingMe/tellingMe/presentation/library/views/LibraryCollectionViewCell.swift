//
//  LibraryCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 27.08.23.
//

import UIKit
import SnapKit
import Then

class LibraryCollectionViewCell: UICollectionViewCell {
    static let id = "libraryCollectionViewCell"
    let stick = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setStyles()
    }
    
    func setData(data: LibraryAnswerList) {
        if data.isEmpty {
            stick.backgroundColor = .clear
        } else if data.isLast {
            stick.transform = CGAffineTransform(rotationAngle: -8 * CGFloat.pi / 180)
            stick.backgroundColor = data.emotion.color
        } else {
            stick.backgroundColor = data.emotion.color
        }
    }
}

extension LibraryCollectionViewCell {
    func setLayout() {
        addSubview(stick)
        stick.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setStyles() {
        stick.do {
            $0.layer.cornerRadius = 4
        }
    }
}
