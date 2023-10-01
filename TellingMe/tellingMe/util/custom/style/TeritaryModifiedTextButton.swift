//
//  TeritaryModifiedTextButton.swift
//  tellingMe
//
//  Created by 마경미 on 13.09.23.
//

import UIKit

class TeritaryModifiedTextButton: UIButton {
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
        backgroundColor = UIColor(named: "Side300")
//        tintColor = UIColor(named: "Logo")
    }

    func setHighlighted() {
        self.setShadow(shadowRadius: 20)
    }

    func setNotHighlighted() {
        self.layer.shadowOpacity = 0
    }

    func setDisabled() {
        backgroundColor = .Side200
    }

    func setDefault() {
        backgroundColor = .Side200
        setTitleColor(.Gray4, for: .disabled)
        setTitleColor(.Gray7, for: .normal)
        titleLabel?.font = .fontNanum(.H6_Regular)
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

