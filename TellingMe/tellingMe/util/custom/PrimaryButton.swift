//
//  PrimaryButton.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class IconButton: UIButton {

}

// class TeritaryVerticalBothButton: UIView {
//    let imageView: UIImageView = {
//        let imgView = UIImageView()
//        return imgView
//    }()
//
//    let label: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "NanumSquareRoundOTF-Regular", size: 17)
//        label.textColor = UIColor(named: "Gray7")
//        return label
//    }()
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        initializeView()
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initializeView()
//    }
//
//    func initializeView() {
//        self.backgroundColor = UIColor(named: "Side200")
//        addSubview(imageView)
//        addSubview(label)
//
//        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 19).isActive = true
//    }
//
//    func setBothwithCustomImage(imageName: String, text: String) {
//        imageView.image = UIImage(named: imageName)
//        label.text = text
//        self.layer.cornerRadius = 20
//    }
//
//    func setBothwithSystemImage(imageName: String, text: String) {
//        imageView.image = UIImage(systemName: imageName)
//        label.text = text
//        self.layer.cornerRadius = 20
//    }
// }
