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
        imageView.image = UIImage(named: "Empty")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let label: Body1Bold = {
        let label = Body1Bold()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Gray5")
        label.text = "이 달에 작성한 글이 없어요!"
        label.textAlignment = .center
        return label
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

        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
}

class NoneCommunicationContentView: UIView {
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Side100")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Empty")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let label: Body1Bold = {
        let label = Body1Bold()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Gray5")
        label.text = "아직 올라온 글이 없어요!"
        label.textAlignment = .center
        return label
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
        addSubview(contentView)
        contentView.widthAnchor.constraint(equalToConstant: 153).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 141).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        addSubview(imageView)
        addSubview(label)

        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
}
