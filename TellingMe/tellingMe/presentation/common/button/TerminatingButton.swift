//
//  TerminatingButton.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/28.
//

import UIKit

import SnapKit
import Then

class TerminatingButton: BBaseButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setAction()
    }
    
    override func setStyles() {
        self.backgroundColor = .Primary25
        self.cornerRadius = 20
        self.setTitle("확인", for: .normal)
        self.setTitleColor(.Logo, for: .normal)
        self.titleLabel?.font = .fontNanum(.H6_Regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TerminatingButton {
    
    private func setAction() {
        self.addTarget(self, action: #selector(terminateApp), for: .touchUpInside)
    }
}

extension TerminatingButton {
    @objc
    private func terminateApp() {
        fatalError("App Terminated due to Network Problem")
    }
}
