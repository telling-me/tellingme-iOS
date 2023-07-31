//
//  BackHeaderView.swift
//  tellingMe
//
//  Created by 마경미 on 31.07.23.
//

import UIKit

protocol DismissButtonDelegate: AnyObject {
    func popViewController()
}

class BackHeaderView: UIView {
    weak var delegate: DismissButtonDelegate?

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = UIColor(named: "Gray6")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21).isActive = true
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true

        backButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }

    @objc func didTapButton(_ sender: UIButton) {
        delegate?.popViewController()
    }
}
