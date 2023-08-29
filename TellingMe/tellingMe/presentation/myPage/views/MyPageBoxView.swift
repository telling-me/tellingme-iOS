//
//  MyPageBoxView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import SnapKit
import Then

final class MyPageBoxView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageBoxView {

    private func bindViewModel() {
        
    }
    
    private func setLayout() {
        self.backgroundColor = .Side200
        self.cornerRadius = 20
        self.layer.masksToBounds = true
        
        
    }
    
    private func setStyles() {
        
    }
}
