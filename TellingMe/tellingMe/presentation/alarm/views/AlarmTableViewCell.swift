//
//  AlarmTableViewCell.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import UIKit

import SnapKit
import Then

final class AlarmTableViewCell: UITableViewCell {
    
    private var alarmNoticeInformation: AlarmNotificationResponse = .init(noticeId: 0, title: "", content: nil, isRead: false, createdAt: [], link: nil, isInternal: false, answerId: nil, date: nil)
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let titleStackView = UIStackView()
    private let dateLabel = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyles()
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlarmTableViewCell {
    private func setStyles() {
        self.backgroundColor = .Side100
        
        titleLabel.do {
            $0.font = .fontNanum(.B2_Bold)
            $0.textColor = .Gray8
            $0.numberOfLines = 1
        }
        
        subTitleLabel.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray8
            $0.numberOfLines = 2
        }
        
        dateLabel.do {
            $0.font = .fontNanum(.C1_Regular)
            $0.textColor = .Gray8
            $0.numberOfLines = 1
        }
        
        titleStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .leading
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleStackView)
        titleStackView.addArrangedSubviews(titleLabel, subTitleLabel, dateLabel)
        
        titleStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.verticalEdges.equalToSuperview().inset(18)
        }
    }
}

extension AlarmTableViewCell {
    private func setTextsFromData(title: String?, subTitle: String?, date: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        dateLabel.text = date
    }
    
    private func resetProperties() {
        self.alarmNoticeInformation = .init(noticeId: 0, title: "", content: nil, isRead: false, createdAt: [], link: nil, isInternal: false, answerId: nil, date: nil)
        self.titleLabel.text = nil
        self.titleLabel.textColor = .Gray8
        self.subTitleLabel.text = nil
        self.subTitleLabel.textColor = .Gray8
        self.dateLabel.text = nil
        self.dateLabel.textColor = .Gray8
    }
    
    private func zipSeperateDateComponentsIntoOne(dateArray: [Int]) -> String {
        var dateCombined: String = ""
        
        for index in 0...2 {
            if index != 2 {
                dateCombined += String(dateArray[index]) + "."
            } else {
                dateCombined += String(dateArray[index])
            }
        }
        return dateCombined
    }
}

extension AlarmTableViewCell {
    func configrue(noticeData: AlarmNotificationResponse) {
        self.alarmNoticeInformation = noticeData
        let dateCombined = zipSeperateDateComponentsIntoOne(dateArray: noticeData.createdAt)
            
        setTextsFromData(title: alarmNoticeInformation.title, subTitle: alarmNoticeInformation.content, date: dateCombined)
        if alarmNoticeInformation.isRead != false {
            noticeIsRead()
        }
    }
    
    func hasOutboundLink() -> Bool {
        return !self.alarmNoticeInformation.isInternal
    }
    
    func getAnswerId() -> Int? {
        return alarmNoticeInformation.answerId
    }
    
    func noticeIsRead() {
        titleLabel.textColor = .Gray3
        subTitleLabel.textColor = .Gray3
        dateLabel.textColor = .Gray3
    }
    
    func getLinkString() -> String? {
        return alarmNoticeInformation.link
    }
    
    func getNoticeId() -> Int {
        return alarmNoticeInformation.noticeId
    }
    
    func getDateString() -> String {
        guard let dateArray = alarmNoticeInformation.date else {
            return "" }
        guard let result = dateArray.intArraytoDate() else {
            return ""}
        return result
    }
}
