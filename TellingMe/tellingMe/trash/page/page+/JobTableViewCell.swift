//
//  JobTableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

import SnapKit

class JobTableViewCell: UITableViewCell {
    static let id = "jobTableViewCell"
    private let cellView = TeritaryBothButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        self.selectionStyle = .none
        
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(with data: Job) {
        cellView.setImageandLabel(imgName: "\(data.imgName)", text: data.title)
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        cellView.backgroundColor = selected ? UIColor(named: "Side300") : UIColor(named: "Side200")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
}
