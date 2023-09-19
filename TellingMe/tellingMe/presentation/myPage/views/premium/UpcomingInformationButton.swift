//
//  UpcomingInformationButton.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/11.
//

import UIKit

final class UpcomingInformationButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UpcomingInformationButton {
    private func setStyles() {
        self.isUserInteractionEnabled = false
        self.isEnabled = false
        self.cornerRadius = 20
        self.backgroundColor = .Primary25
        self.setTitleColor(.Logo, for: .normal)
        self.titleLabel?.font = .fontNanum(.H6_Regular)
    }
}

extension UpcomingInformationButton {
    func setTitleFor(_ title: String) {
        self.setTitle(title, for: .normal)
    }
}
