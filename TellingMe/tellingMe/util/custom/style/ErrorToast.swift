//
//  Toast.swift
//  tellingMe
//
//  Created by 마경미 on 21.04.23.
//

import UIKit

class ErrorToast: UIView {
    var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "exclamationmark.triangle")
        imgView.tintColor = UIColor(named: "Error300")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    var label: CaptionLabelBold = {
        let label = CaptionLabelBold()
        label.textColor = UIColor(named: "Error300")
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
        backgroundColor = UIColor(named: "Error100")
        addSubview(imageView)
        addSubview(label)
    }

    func setLayout() {
        clipsToBounds = false
        cornerRadius = 12
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func setImage(image: String) {
        imageView.image = UIImage(named: image)
    }

    func setMessage(message: String) {
        label.text = message
    }
}
