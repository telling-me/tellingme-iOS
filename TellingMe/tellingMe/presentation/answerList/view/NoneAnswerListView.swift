//
//  NoneAnswerListView.swift
//  tellingMe
//
//  Created by 마경미 on 11.06.23.
//

import Foundation
import UIKit

class NoneAnswerListView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let label: Body1Bold = {
        let label = Body1Bold()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "아직 등록한 답변이 없어요!"
        label.textAlignment = .center
        return label
    }()

    let button: SecondaryTextButton = {
        let button = SecondaryTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setText(text: "답변하러 갈래요")
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        addSubview(imageView)
        addSubview(label)
        addSubview(button)

        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 17).isActive = true

        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
