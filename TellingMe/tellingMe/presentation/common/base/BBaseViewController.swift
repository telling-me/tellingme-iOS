//
//  BaseViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

import SnapKit
import Then

class BBaseViewController: UIViewController {

    private lazy var viewControllerName = self.className
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
    }

    /// Data 와 UI 를 bind 합니다.
    func bindViewModel() {}
    /// View 의 Style 을 set 합니다.
    func setStyles() {}
    /// View 의 Layout 을 set 합니다.
    func setLayout() {}
    
    deinit {
        print("🗑️ \(viewControllerName) succesfully deinited")
    }
}
