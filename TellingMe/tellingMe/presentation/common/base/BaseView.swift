//
//  BaseView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        print("View has been successfully Removed")
    }
}

extension BaseView {
    private func bindViewModel() {}
    private func setStyles() {}
    private func setLayout() {}
}
