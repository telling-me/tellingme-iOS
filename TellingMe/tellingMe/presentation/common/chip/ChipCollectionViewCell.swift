//
//  ChipCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 15.05.23.
//

import UIKit

class ChipCollectionViewCell: UICollectionViewCell {
    static let id = "ChipCollectionViewCell"

    let label: Body2Regular = {
        let label = Body2Regular()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Gray7")
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
        self.backgroundColor = UIColor(named: "Side200")
        self.layer.cornerRadius = 16

        addSubview(label)
    }

    func setData(with data: String) {
        self.label.text = data
        label.sizeToFit()
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    override var isSelected: Bool {
        didSet {
            isSelected ? setSelected() :setDefault()
        }
    }

    func setSelected() {
        self.backgroundColor = UIColor(named: "Side500")
        self.label.textColor = UIColor(named: "Side200")
    }

    func setDefault() {
        self.backgroundColor = UIColor(named: "Side200")
        self.label.textColor = UIColor(named: "Gray7")
    }

    func setDisabled() {
        self.backgroundColor = UIColor(named: "Gray1")
        self.label.textColor = UIColor(named: "Gray4")
    }
}
