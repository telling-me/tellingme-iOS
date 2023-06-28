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
        label.text = "이 달에 작성한 답변이 없어요!"
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
