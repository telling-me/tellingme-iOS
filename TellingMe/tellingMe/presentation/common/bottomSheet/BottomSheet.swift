//
//  BottomSheet.swift
//  tellingMe
//
//  Created by 마경미 on 08.08.23.
//

import UIKit
import RxSwift

class BottomSheet: UIView {
    let titleLabel: Body1Regular = {
        let label = Body1Regular()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subTitleLabel: Body2Regular = {
        let label = Body2Regular()
        label.textColor = UIColor(named: "Gray5")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let cancelButton: TeritaryTextButton = {
        let button = TeritaryTextButton()
        button.setText(text: "취소")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var cancelButtonTapObservable: Observable<Void> {
         return cancelButton.rx.tap.asObservable()
     }

    let okButton: SecondaryTextButton = {
        let button = SecondaryTextButton()
        button.setText(text: "확인")
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var okButtonTapObservable: Observable<Void> {
         return okButton.rx.tap.asObservable()
     }

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        self.layer.cornerRadius = 28
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 42).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        addSubview(stackView)
        stackView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42).isActive = true

        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(okButton)
    }

    func setTitle(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
