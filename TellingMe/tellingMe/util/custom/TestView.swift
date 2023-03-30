//
//  TestView.swift
//  tellingMe
//
//  Created by 마경미 on 29.03.23.
//

import UIKit

class TestView: UIView {
    let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    let label: Headline6Regular = {
        let label = Headline6Regular()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
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

        imgView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 19).isActive = true
        label.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 15).isActive = true
    }
    
//    func setDefaultView() {
//        self.clipsToBounds = true
//        self.layer.backgroundColor = UIColor(named: "Side200")?.cgColor
//        self.layer.cornerRadius = 20
//    }

    func setActiveView() {
        self.layer.backgroundColor = UIColor(named: "Side300")?.cgColor
    }

    func setImageandLabel(imgName: String, text: String) {
        imgView.image = UIImage(named: imgName)
        label.text = text
    }
}
