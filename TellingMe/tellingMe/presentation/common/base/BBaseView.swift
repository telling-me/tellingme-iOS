//
//  BaseView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

import SnapKit
import Then

class BBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
        setStyles()
        setLayout()
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        print("View has been successfully Removed")
    }
    
    /// Data 와 UI 를 bind 합니다.
    func bindViewModel() {}
    /// View 의 Style 을 set 합니다.
    func setStyles() {}
    /// View 의 Layout 을 set 합니다.
    func setLayout() {}

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
