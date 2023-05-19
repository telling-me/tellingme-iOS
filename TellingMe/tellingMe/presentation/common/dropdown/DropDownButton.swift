//
//  dropDownButton.swift
//  tellingMe
//
//  Created by 마경미 on 02.04.23.
//

import UIKit

protocol DropDownButtonDelegate: AnyObject {
    func showDropDown(_ button: DropDownButton)
}

class DropDownButton: UIView {
    weak var delegate: DropDownButtonDelegate?

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
    
    let smallLabel: Body2Regular = {
        let label = Body2Regular()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }

    func initializeView() {
        self.layer.backgroundColor = UIColor(named: "Side200")?.cgColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        self.addGestureRecognizer(tapGestureRecognizer)
        addSubview(imageView)
    }

    func setLayout() {
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true

        self.layer.cornerRadius = 18
    }

    func setMediumLayout() {
        addSubview(label)
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

    func setSmallLayout() {
        addSubview(smallLabel)
        smallLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        smallLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        smallLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        smallLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true

        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        self.layer.cornerRadius = 16
    }

    func setTitle(text: String, isSmall: Bool) {
        if isSmall {
            smallLabel.text = text
        } else {
            label.text = text
        }
    }

    func setOpen() {
        imageView.image = UIImage(systemName: "chevron.up")
    }

    func setClose() {
        imageView.image = UIImage(systemName: "chevron.down")
    }

    @objc func didTapButton(_ sender: UIButton) {
        delegate?.showDropDown(self)
    }
}
