//
//  ReportCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 09.08.23.
//

import UIKit

class ReportCollectionViewCell: UICollectionViewCell {
    static let id = "reportCollectionViewCell"

    override var isSelected: Bool {
        didSet {
            isSelected ? setSelected() : setDefault()
        }
    }

    let label: Headline6Regular = {
        let label = Headline6Regular()
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
        setDefault()
        contentView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    func setData(text: String) {
        label.text = text
        label.sizeToFit()
    }

    func setSelected() {
        self.backgroundColor = UIColor(named: "Side300")
    }
    
    func setDefault() {
        self.backgroundColor = UIColor(named: "Side200")
    }
}
