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
//    var emotion: Int? = nil
//    var title: String? = nil
//    var date: [Int]? = nil
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
        questionLabel.text = data.title.replacingOccurrences(of: "\n", with: " ")
        subQuestionLabel.text = data.phrase
        paragraphStyle.lineHeightMultiple = 1.62
        answerTextView.attributedText = NSMutableAttributedString(string: data.content, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        dateLabel.text = "\(data.date[0])년 \(data.date[1])월 \(data.date[2])일"

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

        dateLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 72).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
}
