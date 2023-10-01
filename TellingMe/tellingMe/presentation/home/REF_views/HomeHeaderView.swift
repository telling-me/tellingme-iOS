//
//  HomeHeaderView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

final class HomeHeaderView: BBaseView {
    
    let alarmButton = BBaseButton(frame: .zero)
    let myPageButton = BBaseButton(frame: .zero)
    private let logoImageView = UIImageView()
    
    override func setLayout() {
        self.backgroundColor = .Side100
        
        logoImageView.do {
            $0.image = ImageLiterals.HomeLogo?.withRenderingMode(.alwaysOriginal)
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
        }
        
        alarmButton.do {
            $0.setImage(ImageLiterals.HomeNoticeAlarm, for: .normal)
            $0.backgroundColor = .clear
        }
        
        myPageButton.do {
            $0.setImage(ImageLiterals.HomeSetting, for: .normal)
            $0.backgroundColor = .clear
        }
    }
    
    override func setStyles() {
        self.addSubviews(logoImageView, myPageButton, alarmButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(25)
            $0.width.equalTo(81)
            $0.height.equalTo(34)
        }
        
        myPageButton.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView.snp.centerY)
            $0.size.equalTo(26)
            $0.trailing.equalToSuperview().inset(21)
        }
        
        alarmButton.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView.snp.centerY)
            $0.size.equalTo(26)
            $0.trailing.equalTo(myPageButton.snp.leading).offset(-12)
        }
    }
}

extension HomeHeaderView {
    func checkIfNewAlarmsExist(_ check: Bool) {
        switch check {
        case true:
            alarmButton.setImage(ImageLiterals.HomeNoticeAlarmWithDot, for: .normal)
        case false:
            alarmButton.setImage(ImageLiterals.HomeNoticeAlarm, for: .normal)
        }
    }
}
