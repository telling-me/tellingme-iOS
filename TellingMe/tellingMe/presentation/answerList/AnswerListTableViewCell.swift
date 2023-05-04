//
//  AnswerListTableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import UIKit

class AnswerListTableViewCell: UITableViewCell {
    static let id = "answerListTableViewCell"
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = CaptionLabelRegular()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setCell(data: AnswerListResponse) {
        contentView.addSubview(containerView)

        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 19).isActive = true

        containerView.addSubview(imgView)
        containerView.addSubview(questionLabel)
        containerView.addSubview(dateLabel)

        imgView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imgView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        questionLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 20).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        questionLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true

        dateLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true

        imgView.image = UIImage(named: "emotion\(data.emotion)")
        questionLabel.text = data.title
        dateLabel.text = "\(data.date[0])년 \(data.date[1])월 \(data.date[2])일"
    }
//
//    func getCell() -> String {
//        return label.text ?? ""
//    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = selected ? UIColor(named: "Side200") : UIColor(named: "Side100")
    }
}
