//
//  GenderCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 02.04.23.
//

import UIKit

class GenderCollectionViewCell: UICollectionViewCell {
    static let id = "genderCollectionViewCell"
    @IBOutlet weak var cellView: TeritaryVerticalBothButton!

    override var isSelected: Bool {
      didSet {
        if isSelected {
            setSelected()
        } else {
            setDefault()
        }
      }
    }

    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? setHighlighted(): setNotHighlighted()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setData(with data: TeritaryBothData) {
        cellView.setImageandLabel(imgName: data.imgName, text: data.title)
        cellView.backgroundColor = UIColor(named: "Side200")
        cellView.layer.masksToBounds = true
        cellView.layer.cornerRadius = 20
    }

    func setSelected() {
        cellView.backgroundColor = UIColor(named: "Side300")
    }

    func setDefault() {
        cellView.backgroundColor = UIColor(named: "Side200")
    }

    func setHighlighted() {
        cellView.setHeighlighted()
    }

    func setNotHighlighted() {
        cellView.setNotHighlighted()
    }
}
