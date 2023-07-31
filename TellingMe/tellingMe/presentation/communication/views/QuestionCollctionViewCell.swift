//
//  QuestionCollctionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 30.07.23.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    static let id = "questionCollectionViewCell"

    let questionView = QuestionView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }


    func setView() {
        questionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionView)
        questionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        questionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        questionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        questionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    func setData(data: QuestionResponse) {
        questionView.setQuestion(data: data)
    }
}
