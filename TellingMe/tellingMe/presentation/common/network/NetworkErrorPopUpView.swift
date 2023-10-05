//
//  NetworkErrorPopUpView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/28.
//

import UIKit

final class NetworkErrorPopUpView: BBaseView {
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let mainImageView = UIImageView()
    private let terminateAppButton = TerminatingButton(frame: .zero)
    
    override func setStyles() {
        self.backgroundColor = .Side100
        self.cornerRadius = 20
        
        titleLabel.do {
            $0.text = "네트워크 연결에 실패했어요."
            $0.textColor = .Black
            $0.textAlignment = .center
            $0.font = .fontNanum(.B1_Bold)
        }
        
        subTitleLabel.do {
            $0.text = "네트워크 환경을 확인해주세요."
            $0.textColor = .Gray6
            $0.textAlignment = .center
            $0.font = .fontNanum(.B2_Regular)
        }
        
        mainImageView.do {
            $0.image = ImageLiterals.WorkInProgress
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel, subTitleLabel, terminateAppButton, 
                         mainImageView)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(30)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        terminateAppButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        mainImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(terminateAppButton.snp.top).offset(-20)
            $0.width.equalTo(mainImageView.snp.height)
        }
    }
}
