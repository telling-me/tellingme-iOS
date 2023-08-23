//
//  CardListCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 04.07.23.
//

import UIKit

class CardListCollectionViewCell: UICollectionViewCell {
    static let id = "cardListCollectionViewCell"
    let emotions = ["Happy", "Proud", "Meh", "Tired", "Sad", "Angry"]
    var paragraphStyle = NSMutableParagraphStyle()
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let questionLabel: UILabel = {
        let label = Body2Regular()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subQuestionLabel: UILabel = {
        let label = CaptionLabelRegular()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let answerTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "NanumSquareRoundOTFR", size: 12)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let dateLabel: UILabel = {
        let label = CaptionLabelRegular()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setCell(data: AnswerListResponse) {
        imgView.image = UIImage(named: self.emotions[data.emotion - 1])
        questionLabel.text = data.title
        subQuestionLabel.text = data.phrase
        guard let font = answerTextView.font else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5

        let attributedText = NSMutableAttributedString(string: data.content)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        attributedText.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))

        answerTextView.attributedText = attributedText
        dateLabel.text = data.date.intArraytoDate2()

        contentView.backgroundColor = UIColor(named: "Side100")
        contentView.addSubview(containerView)

        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 34).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 34).isActive = true

        containerView.addSubview(imgView)
        containerView.addSubview(questionLabel)
        containerView.addSubview(subQuestionLabel)
        containerView.addSubview(answerTextView)
        containerView.addSubview(dateLabel)

        imgView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        imgView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        questionLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 20).isActive = true
        questionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

        subQuestionLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 12).isActive = true
        subQuestionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

        answerTextView.topAnchor.constraint(equalTo: subQuestionLabel.bottomAnchor, constant: 38).isActive = true
        answerTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        answerTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        answerTextView.heightAnchor.constraint(equalToConstant: 154).isActive = true

        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -72).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true

        contentView.layer.cornerRadius = 24
    }
}
