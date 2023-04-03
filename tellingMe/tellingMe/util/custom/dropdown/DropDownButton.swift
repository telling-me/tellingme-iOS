//
//  dropDownButton.swift
//  tellingMe
//
//  Created by 마경미 on 02.04.23.
//

import UIKit

class DropDownButton: UIView {
    let label: Body1Regular = {
        let label = Body1Regular()
        label.textColor = UIColor(named: "Gray4")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = UIColor(named: "Side500")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }

    init(frame: CGRect, isSmall: Bool) {
        super.init(frame: frame)
        initializeView()
    }

    func initializeView() {
        self.layer.backgroundColor = UIColor(named: "Side200")?.cgColor
        addSubview(label)
        addSubview(imageView)
    }

    func setLayout() {
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true

        self.layer.cornerRadius = 18
    }

    func setSmallLayout() {
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 4).isActive = true

        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        self.layer.cornerRadius = 18
    }

    func setTitle(text: String) {
        label.text = text
    }

    func setOpen() {
        imageView.image = UIImage(systemName: "chevron.up")
    }

    func setClose() {
        imageView.image = UIImage(systemName: "chevron.down")
    }
}
