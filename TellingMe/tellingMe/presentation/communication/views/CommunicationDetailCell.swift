//
//  CommunicationDetailCell.swift
//  tellingMe
//
//  Created by 마경미 on 28.07.23.
//

import UIKit

class CommunicationDetailCollectionViewCell: UICollectionViewCell {
    static let id = "communicationDetailCollectionViewCell"

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let emotionView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let emotionLabel: Body2Bold = {
        let label = Body2Bold()
        label.textColor = UIColor(named: "Gray7")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let answerLabel: Body2Regular = {
        let label = Body2Regular()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(named: "Gray6")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }

    func setView() {
        self.layer.cornerRadius = 12

        contentView.backgroundColor = UIColor(named: "Side200")
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true

        containerView.addSubview(emotionView)
        emotionView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        emotionView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        emotionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        emotionView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        containerView.addSubview(emotionLabel)
        emotionLabel.leadingAnchor.constraint(equalTo: emotionView.trailingAnchor, constant: 8).isActive = true
        emotionLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        emotionLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        containerView.addSubview(answerLabel)
        answerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        answerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        answerLabel.topAnchor.constraint(equalTo: emotionView.bottomAnchor, constant: 8).isActive = true

        containerView.addSubview(likeButton)
        likeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        likeButton.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 4).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }

    func setData(data: Content) {
        answerLabel.text = data.content
    }
}
