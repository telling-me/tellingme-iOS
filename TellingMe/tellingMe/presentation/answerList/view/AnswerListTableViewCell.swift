//
//  AnswerListTableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import UIKit

class AnswerListTableViewCell: UITableViewCell {
    let emotions = ["Happy", "Proud","Meh", "Tired", "Sad", "Angry"]
    static let id = "answerListTableViewCell"
    var emotion: Int? = nil
    var title: String? = nil
    var date: [Int]? = nil

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
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 18).isActive = true

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

        self.emotion = data.emotion
        self.title = data.title
        self.date = data.date
        imgView.image = UIImage(named: self.emotions[data.emotion])
        questionLabel.text = self.title!.replacingOccurrences(of: "\n", with: " ")
        dateLabel.text = "\(self.date![0])년 \(self.date![1])월 \(self.date![2])일"
    }

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
