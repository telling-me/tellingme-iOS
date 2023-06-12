//
//  SecondayTextButton.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import UIKit

class SecondaryTextButton: UIButton {
    override var isSelected: Bool {
        didSet {
            isSelected ? setSelected() : setDefault()
        }
    }
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? setHighlighted(): setNotHighlighted()
        }
    }
    override var isEnabled: Bool {
        didSet {
            isEnabled ? setDefault(): setDisabled()
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

    func setSelected() {
        backgroundColor = UIColor(named: "Primary300")
    }

    func setHighlighted() {
        self.setShadow(shadowRadius: 20)
    }

    func setNotHighlighted() {
        self.layer.shadowOpacity = 0
    }

    func setDisabled() {
        backgroundColor = UIColor(named: "Gray1")
    }

    func setDefault() {
        backgroundColor = UIColor(named: "Primary25")
        setTitleColor(UIColor(named: "Gray4"), for: .disabled)
        setTitleColor(UIColor(named: "Logo"), for: .normal)
        titleLabel?.font = UIFont(name: "NanumSquareRoundOTFR", size: 17)
    }

    private func setupButton() {
        layer.cornerRadius = 20
        setDefault()
        self.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        sender.isHighlighted = true
    }

    @objc func buttonReleased(_ sender: UIButton) {
        sender.isHighlighted = false
    }

    func setText(text: String) {
        setTitle(text, for: .normal)
    }
}
