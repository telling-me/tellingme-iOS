//
//  HomePushNotificationPopUpView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/28.
//

import UIKit

final class HomePushNotificationPopUpView: BBaseView {
    
    private let isDeviceAbnormal = UserDefaults.standard.bool(forKey: StringLiterals.isDeviceAbnormal)
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let mainImageView = UIImageView()
    let declineButton = CommonRoundButton()
    let permitButton = CommonRoundButton()

    override func setStyles() {
        self.backgroundColor = .Side100
        self.cornerRadius = 20
        
        var titleFont = UIFont()
        var subTitleFont = UIFont()
        if isDeviceAbnormal != false {
            titleFont = .fontNanum(.B2_Bold)
            subTitleFont = .fontNanum(.C1_Regular)
        } else {
            titleFont = .fontNanum(.B1_Bold)
            subTitleFont = .fontNanum(.B2_Regular)
        }
        
        titleLabel.do {
            $0.text = "하루 한번 오후 6시에 알림을 드려도 될까요?"
            $0.textColor = .Black
            $0.textAlignment = .center
            $0.numberOfLines = 1
            $0.font = titleFont
        }
        
        subTitleLabel.do {
            $0.text = "매일 기록을 잊지 않게 해드릴게요!"
            $0.textColor = .Gray5
            $0.font = subTitleFont
            $0.textAlignment = .center
            $0.numberOfLines = 1
        }
        
        mainImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = ImageLiterals.PushNotificationAlarm
        }
        
        declineButton.do {
            $0.setTitleWithColor(text: "괜찮아요", color: .Gray5)
            $0.setBackgroundColor(with: .clear)
            $0.titleLabel?.font = .fontNanum(.B1_Regular)
        }
        
        permitButton.do {
            $0.setTitleWithColor(text: "좋아요", color: .Logo)
            $0.setBackgroundColor(with: .Primary25)
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel, subTitleLabel, declineButton, 
                         permitButton, mainImageView)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(18)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17)
        }
        
        declineButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(32)
        }
        
        permitButton.snp.makeConstraints {
            $0.bottom.equalTo(declineButton.snp.top).offset(-16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        mainImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(permitButton.snp.top).offset(-24)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(28)
            $0.width.equalTo(mainImageView.snp.height)
        }
    }
}
