//
//  SecondayIconButton.swift
//  tellingMe
//
//  Created by 마경미 on 20.04.23.
//

import UIKit

class SecondayIconButton: UIButton {
    var shadows = UIView()

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
        backgroundColor = UIColor(named: "Priamry300")
        tintColor = UIColor(named: "Logo")
    }

    func setHighlighted() {
        shadows.isHidden = false
    }

    func setNotHighlighted() {
        shadows.isHidden = true
    }

    func setDisabled() {
        backgroundColor = UIColor(named: "Gray1")
        tintColor = UIColor(named: "Gray4")
    }
    
    func setDefault() {
        backgroundColor = UIColor(named: "Primary25")
        tintColor = UIColor(named: "Logo")
    }

    private func setupButton() {
        setTitle(nil, for: .normal)
        layer.cornerRadius = 20
        setDefault()

        shadows.frame = self.frame
        shadows.clipsToBounds = false
        self.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 20)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 20
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        
        self.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        sender.isHighlighted = true
        // custom highlighted state 작업
    }

    @objc func buttonReleased(_ sender: UIButton) {
        sender.isHighlighted = false
        // custom normal state 작업
    }

    func setImage(image: String) {
        setImage(UIImage(named: image), for: .normal)
    }
}
