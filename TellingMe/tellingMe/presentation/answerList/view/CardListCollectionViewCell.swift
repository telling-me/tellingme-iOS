//
//  CardListCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 04.07.23.
//

import UIKit

import SnapKit
import Then

protocol ShareButtonTappedProtocol: AnyObject {
    func shareButtonTapped(passing view: UIView)
}

final class CardListCollectionViewCell: UICollectionViewCell {
    weak var delegate: ShareButtonTappedProtocol?
    static let id = "cardListCollectionViewCell"
    let emotions = ["Happy", "Proud", "Meh", "Tired", "Sad", "Angry"]
    var paragraphStyle = NSMutableParagraphStyle()
    private let instaManager = MetaManager()
    
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
        label.textColor = .Gray7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subQuestionLabel: UILabel = {
        let label = CaptionLabelRegular()
        label.textAlignment = .center
        label.textColor = .Gray5
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
        textView.textColor = .Black
        return textView
    }()

    let dateLabel: UILabel = {
        let label = CaptionLabelRegular()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Side500
        label.font = .fontNanum(.C1_Regular)
        return label
    }()
    
    let shareIconButton: UIButton = {
        let button = UIButton(type: .custom)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18)
        button.setImage(UIImage(systemName: "square.and.arrow.up", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .Gray5
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        // 밖에서 처리하기
        button.addTarget(self, action: #selector(tapToShare(_:)), for: .touchUpInside)
        return button
    }()
    
    let tellingMeSignatureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .Gray3
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        containerView.addSubview(shareIconButton)
        containerView.addSubview(tellingMeSignatureImageView)

        imgView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        imgView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        questionLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 20).isActive = true
        questionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

        subQuestionLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 12).isActive = true
        subQuestionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

        answerTextView.topAnchor.constraint(equalTo: subQuestionLabel.bottomAnchor, constant: 20).isActive = true
        answerTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        answerTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        

        dateLabel.topAnchor.constraint(equalTo: answerTextView.bottomAnchor, constant: 14).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -33).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true

        contentView.layer.cornerRadius = 24
        
        shareIconButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -33).isActive = true
        shareIconButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        shareIconButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
    }
}

extension CardListCollectionViewCell {
    @objc
    private func tapToShare(_ sender: UIButton) {
        self.delegate?.shareButtonTapped(passing: self)
    }
}
