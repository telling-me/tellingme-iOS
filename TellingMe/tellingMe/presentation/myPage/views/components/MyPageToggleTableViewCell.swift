//
//  MyPageToggleTableViewCell.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/06.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class MyPageToggleTableViewCell: UITableViewCell {
    
    private let viewModel = MyPageViewModel()
    private let settingViewModel = SettingViewModel()
    private var disposeBag = DisposeBag()
    
    private let cellTitleLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let notificationToggle = UISwitch()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageToggleTableViewCell {
    
    private func bindViewModel() {
        viewModel.outputs.userInformation
            .bind { [weak self] response in
                self?.notificationToggle.isOn = response.allowNotification
            }
            .disposed(by: disposeBag)
        
        notificationToggle.rx.isOn
            .skip(1)
            .do { [weak self] _ in
                self?.notificationToggle.isEnabled = false
            }
            .delay(.milliseconds(700), scheduler: MainScheduler.instance)
            .do { [weak self] _ in
                self?.notificationToggle.isEnabled = true
            }
            .subscribe(onNext: { [weak self] response in
                print("🧩 Posting Push Permission Sent to the server. : toggled to - \(response)")
                self?.settingViewModel.postNotification(response)
            })
            .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        self.backgroundColor = .clear
        
        cellTitleLabel.do {
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Gray8
        }
        
        notificationToggle.do {
            $0.preferredStyle = .sliding
            $0.onTintColor = .Logo
        }
    }
    
    private func setLayout() {
        self.addSubviews(cellTitleLabel)
        self.contentView.addSubview(notificationToggle)
        
        cellTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.centerY.equalToSuperview()
        }

        notificationToggle.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(21)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
    }
}

extension MyPageToggleTableViewCell {
    func configure(title: String) {
        cellTitleLabel.text = title
    }
}

