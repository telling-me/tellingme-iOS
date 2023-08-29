//
//  MyPageViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class MyPageViewController: UIViewController {

    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
}

extension MyPageViewController {
    
    private func bindViewModel() {
        
    }
    
    private func setLayout() {
        
    }
    
    private func setStyles() {
        
    }
}
