//
//  DividerFooterView.swift
//  tellingMe
//
//  Created by 마경미 on 27.08.23.
//

import UIKit
import SnapKit

class DividerFooterView: UICollectionReusableView {
    static let id = "dividerFooterView"
    let view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

extension DividerFooterView {
    func setLayout() {
        addSubview(view)
        view.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(57)
            $0.top.trailing.equalToSuperview()
            $0.height.equalTo(8)
        }
    }
    
    func setStyles() {
        view.do {
            $0.backgroundColor = UIColor.black
            $0.layer.cornerRadius = 4
        }
    }
}
