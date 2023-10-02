//
//  StickView.swift
//  tellingMe
//
//  Created by 마경미 on 25.09.23.
//

import UIKit

import SnapKit
import Then

final class StickView: UIView {
    private let stick = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("StickView Deinit")
    }
}

extension StickView {
    private func setLayout() {
        addSubview(stick)
        
        stick.snp.makeConstraints {
            $0.width.equalTo(0.5)
            $0.center.height.equalToSuperview()
        }
    }
    
    private func setStyles() {
        stick.do {
            $0.backgroundColor = .Side400
        }
    }
}
