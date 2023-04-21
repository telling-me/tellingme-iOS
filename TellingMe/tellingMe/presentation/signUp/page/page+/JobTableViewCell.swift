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

    let input: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        textField.textColor = UIColor(named: "Gray5")
        textField.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        textField.placeholder = "직접 입력"
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

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

    func setData(with data: JobViewModel) {
        cellView.setImageandLabel(imgName: "\(data.imgName)_Gradient", text: data.title)
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }

    func setEnabledTextField() {
        cellView.addSubview(input)

        input.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 24).isActive = true
        input.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -24).isActive = true
        input.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -18).isActive = true
    }

    func setDisabledTextField() {
        input.removeFromSuperview()
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
