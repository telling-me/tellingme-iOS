//
//  EmotionView.swift
//  tellingMe
//
//  Created by 마경미 on 09.08.23.
//

import Foundation
import UIKit

class EmotionView: UIView {
    let emotionLabel: Body2Bold = {
        let label = Body2Bold()
        label.textColor = UIColor(named: "Gray6")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let emotionLabelBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Side200")
        return view
    }()

    let emotionImageView: UIImageView = {
        let imageView = UIImageView()
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
        addSubview(emotionImageView)

        emotionImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        emotionImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        emotionImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        emotionImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        addSubview(emotionLabelBackgroundView)
        emotionLabelBackgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        emotionLabelBackgroundView.leadingAnchor.constraint(equalTo: emotionImageView.trailingAnchor, constant: 8).isActive = true
        emotionLabelBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        addSubview(emotionLabel)
        emotionLabel.leadingAnchor.constraint(equalTo: emotionLabelBackgroundView.leadingAnchor, constant: 4).isActive = true
        emotionLabel.trailingAnchor.constraint(equalTo: emotionLabelBackgroundView.trailingAnchor, constant: -4).isActive = true
        emotionLabel.topAnchor.constraint(equalTo: emotionLabelBackgroundView.topAnchor, constant: 4).isActive = true
        emotionLabel.bottomAnchor.constraint(equalTo: emotionLabelBackgroundView.bottomAnchor, constant: -4).isActive = true
        emotionLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    func setText(index: Int) {
        emotionLabel.text = emotions[index - 1].text
        emotionImageView.image = UIImage(named: emotions[index - 1].image)
    }
}
