//
//  SecondayIconButton.swift
//  tellingMe
//
//  Created by 마경미 on 20.04.23.
//

import UIKit

class SecondayIconButton: UIButton {
    override var isSelected: Bool {
        didSet {
            isSelected ? setSelected() :setDefault()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? setHighlighted(): setDefault()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            isEnabled ? setEnabled(): setDefault()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    func setHighlighted() {
        shadows.isHidden = false
    }

    func setNotHighlighted() {
        shadows.isHidden = true
    }
    
    func setDefault() {
        
    }

    private func setupButton() {
        backgroundColor = UIColor(named: "Primary25")
        tintColor = UIColor(named: "Logo")
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
    }
    
    func setImage(image: String) {
        setImage(UIImage(named: image), for: .normal)
    }
}
