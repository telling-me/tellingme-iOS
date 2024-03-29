//
//  BoxCheckboxView.swift
//  tellingMe
//
//  Created by 마경미 on 27.09.23.
//

import UIKit

import SnapKit
import Then

final class BoxCheckboxView: UIView {    
    let checkButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxCheckboxView {
    private func setLayout() {
        addSubview(checkButton)
        
        checkButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func setStyles() {
        backgroundColor = .Primary25
        layer.cornerRadius = 18
        
        checkButton.do {
            $0.setImage(UIImage(named: "Checkbox"), for: .normal)
            $0.setImage(UIImage(named: "SelectedCheckbox"), for: .selected)
            $0.titleLabel?.font = .fontNanum(.B1_Regular)
            $0.setTitleColor(.Black, for: .normal)
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
    }
}

extension BoxCheckboxView {
    func setCheckbox(title: String) {
        checkButton.setTitle(title, for: .normal)
    }
}
