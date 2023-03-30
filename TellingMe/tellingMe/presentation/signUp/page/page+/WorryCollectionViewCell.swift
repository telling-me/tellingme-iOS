//
//  WorryCollectionViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 29.03.23.
//

import UIKit

class WorryCollectionViewCell: UICollectionViewCell {
    static let id = "worryCollectionViewCell"

    @IBOutlet weak var cellView: TestView!
    
    override var isSelected: Bool {
      didSet {
        if isSelected {
            setSelected()
        } else {
            setDefault()
        }
      }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setData(with data: WorryViewModel) {
        cellView.setImageandLabel(imgName: data.imgName, text: data.title)
        cellView.backgroundColor = UIColor(named: "Side200")
        cellView.layer.cornerRadius = 20
    }

    func setSelected() {
        cellView.backgroundColor = UIColor(named: "Side300")
    }

    func setDefault() {
        cellView.backgroundColor = UIColor(named: "Side200")
    }
}
