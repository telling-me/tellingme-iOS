//
//  TestView.swift
//  tellingMe
//
//  Created by 마경미 on 29.03.23.
//

import UIKit

class TertiaryVerticalBothButton: UIView {
    let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    let label: Headline6Regular = {
        let label = Headline6Regular()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    var shadows = UIView()
    let layer0 = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    func setView() {
        self.backgroundColor = UIColor(named: "Side200")
        addSubview(imgView)
        addSubview(label)

        imgView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 19).isActive = true
        label.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 15).isActive = true
    
        shadows.frame = self.frame
        shadows.clipsToBounds = false
        self.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 20)
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 20
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
    
        shadows.isHidden = true
    }

    func setActiveView() {
        self.layer.backgroundColor = UIColor(named: "Side300")?.cgColor
    }

    func setImageandLabel(imgName: String, text: String) {
        imgView.image = UIImage(named: imgName)
        label.text = text
    }

    func setHeighlighted() {
        shadows.isHidden = false
    }

    func setNotHighlighted() {
        shadows.isHidden = true
    }
}
