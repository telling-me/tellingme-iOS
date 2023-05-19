//
//  SettingHeaderView.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import UIKit

protocol SettingHeaderViewDelegate: AnyObject {
    func popViewController(_ headerView: SettingHeaderView)
}

class SettingHeaderView: UIView {
    weak var delegate: SettingHeaderViewDelegate?

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = UIColor(named: "Gray6")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let label: Headline6Bold = {
        let label = Headline6Bold()
        label.textColor = UIColor(named: "Gray6")
        label.translatesAutoresizingMaskIntoConstraints = false
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
        backgroundColor = UIColor(named: "Side100")
        addSubview(backButton)
        addSubview(label)

        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21).isActive = true
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true

        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 19).isActive = true

        backButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    func setTitle(title: String) {
        self.label.text = title
        label.sizeToFit()
    }

    @objc func didTapButton(_ sender: UIButton) {
        delegate?.popViewController(self)
    }
}
