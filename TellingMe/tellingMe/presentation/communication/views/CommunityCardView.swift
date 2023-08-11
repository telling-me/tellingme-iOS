//
//  CommunityCardView.swift
//  tellingMe
//
//  Created by 마경미 on 22.07.23.
//

import UIKit

protocol CommunityDelegate: AnyObject {
    func communicationButtonClicked(_ self: CommunityCardView)
}

class CommunityCardView: UIView {
    var delegate: CommunityDelegate?
    
    let questionLabel: Body2Regular = {
        let label = Body2Regular()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: CaptionLabelRegular = {
        let label = CaptionLabelRegular()
        label.textColor = UIColor(named: "Side500")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "comment")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let commentCountLabel: CaptionLabelBold = {
        let label = CaptionLabelBold()
        label.textColor = UIColor(named: "Gray7")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "entrance"), for: .normal)
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
        self.backgroundColor = UIColor(named: "Side200")
        self.layer.cornerRadius = 20

        self.addSubview(questionLabel)
        questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true

        self.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        dateLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true

        self.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24).isActive = true

        self.addSubview(commentCountLabel)
        commentCountLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        commentCountLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        self.addSubview(button)
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        button.widthAnchor.constraint(equalToConstant: 36).isActive = true
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true

        button.addTarget(self, action: #selector(clickedButton), for: .touchUpInside)
    }

    @objc func clickedButton(sender: UIButton) {
        delegate?.communicationButtonClicked(self)
    }

    func setData(data: QuestionListResponse) {
        questionLabel.text = data.title
        dateLabel.text = "\(data.date.intArraytoDate2())"
        commentCountLabel.text = "\(data.answerCount)"
    }
}
