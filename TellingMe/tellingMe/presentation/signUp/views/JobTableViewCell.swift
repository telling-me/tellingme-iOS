//
//  JobTableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

import RxSwift
import SnapKit
import Then

class JobTableViewCell: UITableViewCell {
    static let id = "jobTableViewCell"
    
    private let cellView = TeritaryBothButton()
    private let etcInputBox = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    
    var textObservable: Observable<String?> {
        return etcInputBox.rx.text.asObservable()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        self.selectionStyle = .none
        setStyles()
        setLayout()
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

extension JobTableViewCell {
    private func setLayout() {
        contentView.addSubview(cellView)
        cellView.addSubviews(etcInputBox)

        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        etcInputBox.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
    
    private func setStyles() {
        etcInputBox.do {
            $0.textColor = UIColor(named: "Gray5")
            $0.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
            $0.font = .fontNanum(.B1_Regular)
            $0.placeholder = "직접 입력"
            $0.textAlignment = .center
            $0.returnKeyType = .done
            $0.isHidden = true
        }
    }
}

extension JobTableViewCell {
    func showEtcInputBox() {
        etcInputBox.text = ""
        etcInputBox.isHidden = false
    }
    
    func hiddenEtcInputBox() {
        etcInputBox.isHidden = true
    }
}
