//
//  QuestionView.swift
//  tellingMe
//
//  Created by 마경미 on 25.07.23.
//

import UIKit

class QuestionView: UIView {
    let questionContentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let questionLabel: Body1Bold = {
       let label = Body1Bold()
        label.textColor = UIColor(named: "Gray7")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subQuestionLabel: Body2Regular = {
        let label = Body2Regular()
        label.textColor = UIColor(named: "Gray7")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: CaptionLabelRegular = {
        let label = CaptionLabelRegular()
        label.textColor = UIColor(named: "Side500")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.addSubview(questionContentView)
        questionContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 55).isActive = true
        questionContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -55).isActive = true
        questionContentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        questionContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 24).isActive = true
        
        questionContentView.addSubview(questionLabel)
        questionLabel.centerXAnchor.constraint(equalTo: questionContentView.centerXAnchor).isActive = true
        questionLabel.topAnchor.constraint(equalTo: questionContentView.topAnchor).isActive = true
        
        questionContentView.addSubview(subQuestionLabel)
        subQuestionLabel.centerXAnchor.constraint(equalTo: questionContentView.centerXAnchor).isActive = true
        subQuestionLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 10).isActive = true
        
        questionContentView.addSubview(dateLabel)
        dateLabel.centerXAnchor.constraint(equalTo: questionContentView.centerXAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: questionContentView.bottomAnchor).isActive = true
    }
}

class ColorQuestionView: QuestionView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        questionLabel.textColor = UIColor(named: "Logo")
        subQuestionLabel.textColor = UIColor(named: "Gray5")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        questionLabel.textColor = UIColor(named: "Logo")
        subQuestionLabel.textColor = UIColor(named: "Gray5")
    }
}
