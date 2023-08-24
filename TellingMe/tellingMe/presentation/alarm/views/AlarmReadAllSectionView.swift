//
//  AlarmReadAllSectionView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/24.
//

import UIKit

import SnapKit
import Then

final class AlarmReadAllSectionView: UIView {

    private var isAllRead: Bool = false {
        didSet {
            if isAllRead != false {
                readAllButton.setImage(UIImage(named: "readAllDisabled"), for: .normal)
                readAllButton.isEnabled = false
            } else {
                readAllButton.setImage(UIImage(named: "readAllEnabled"), for: .normal)
                readAllButton.isEnabled = true
            }
        }
    }
    
    let readAllButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let image: UIImage? = self.isAllRead != false ? UIImage(named: "readAllDisabled") : UIImage(named: "readAllEnabled")
        readAllButton.setImage(image, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlarmReadAllSectionView {
    private func setStyles() {
        self.backgroundColor = .Side100
        
        readAllButton.do {
            $0.contentMode = .scaleAspectFit
            $0.layer.masksToBounds = true
        }
    }
    
    private func setLayout() {
        self.addSubview(readAllButton)
        
        readAllButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.verticalEdges.equalToSuperview().inset(4)
//            $0.width.equalTo(70)
        }
    }
}

extension AlarmReadAllSectionView {
    func isAllNoticeRead(_ bool: Bool) {
        self.isAllRead = bool
    }
}

