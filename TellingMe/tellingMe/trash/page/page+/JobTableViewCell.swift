//
//  JobTableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    static let id = "jobTableViewCell"
    @IBOutlet weak var cellView: TeritaryBothButton!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        self.selectionStyle = .none
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(with data: GetJobViewModel.Job) {
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
