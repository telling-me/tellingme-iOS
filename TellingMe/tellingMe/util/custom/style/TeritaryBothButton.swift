//
//  TeritaryBothButton.swift
//  tellingMe
//
//  Created by 마경미 on 31.03.23.
//

import Foundation
import UIKit

class TeritaryBothButton: UIView {
    let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    let label: Headline6Regular = {
        let label = Headline6Regular()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()

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

        imgView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true

        label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 48).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
    }

    func setActiveView() {
        self.layer.backgroundColor = UIColor(named: "Side300")?.cgColor
    }

    func setImageandLabel(imgName: String, text: String) {
        imgView.image = UIImage(named: imgName)
        label.text = text
    }
}
