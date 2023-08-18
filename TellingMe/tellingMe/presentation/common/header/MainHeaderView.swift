//
//  HeaderView.swift
//  tellingMe
//
//  Created by 마경미 on 27.04.23.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func pushSetting(_ headerView: MainHeaderView)
}

class MainHeaderView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        backgroundColor = UIColor(named: "Side100")
        addSubview(imageView)

        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 81).isActive = true
    }
}

class MainSettingHeaderView: MainHeaderView {
    weak var delegate: HeaderViewDelegate?
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Setting"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addButton()
    }

    func addButton() {
        addSubview(button)
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true

        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        delegate?.pushSetting(self)
    }
}
