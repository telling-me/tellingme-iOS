//
//  LikeButton.swift
//  tellingMe
//
//  Created by 마경미 on 12.08.23.
//

import Foundation
import UIKit

class LikeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }

    func setView() {
        self.setImage(UIImage(named: "Heart"), for: .normal)
        self.setImage(UIImage(named: "Heart.fill"), for: .selected)
        self.setTitleColor(UIColor(named: "Gray7"), for: .normal)
        self.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFB", size: 12)
        let spacing: CGFloat = 4
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
    }
}
