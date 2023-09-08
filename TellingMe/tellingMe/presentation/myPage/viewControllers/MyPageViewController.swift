//
//  MyPageViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class MyPageViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private let viewModel = MyPageViewModel()
    private var isDeviceAbnormal = false
    private var rowHeight: CGFloat {
        if isDeviceAbnormal != false {
            return 48
        } else {
            return 56
        }
    }
    private var boxHeight: CGFloat {
        if isDeviceAbnormal != false {
            return 80
        } else {
            return 94
        }
    }
    private var profileProportion: CGFloat {
        if isDeviceAbnormal != false {
            return 7.2
        } else {
            return 6.7
        }
    }
    private var tableViewBottom: CGFloat {
        if isDeviceAbnormal != false {
            return 74
        } else {
            return 93
        }
    }
    
    private let navigationBarView = MyPageHeaderView()
    private let profileView = MyPageProfileView()
    private let boxView = MyPageBoxView()
    private let settingTableView = UITableView()
    private let contactImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    deinit {
        print("MyPageViewController Out")
    }
}

extension MyPageViewController {
    
    private func bindViewModel() {
        navigationBarView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.userInformation
            .bind { [weak self] response in
                self?.profileView.setUserName(userName: response.nickname)
                self?.profileView.setConsecutiveDay(day: response.answerRecord)
                self?.profileView.setUserProfileImage(urlString: response.profileUrl)
                self?.profileView.isUserPremiumUser(isPremium: response.isPremium)
            }
            .disposed(by: disposeBag)
        
        boxView.mainIconCollectionView.rx.itemSelected
            .subscribe {
                print($0, "🍕")
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.settingElements
            .bind(to: settingTableView.rx.items) {
                (tableView, row, item) -> UITableViewCell in
                if row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingToggleTableView", for: IndexPath(row: row, section: 0)) as? MyPageToggleTableViewCell else { return UITableViewCell() }
                    cell.configure(title: item.elementTitle)
                    cell.selectionStyle = .none
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingTableView", for: IndexPath(row: row, section: 0)) as? MyPageTableViewCell else { return UITableViewCell() }
                    cell.configure(title: item.elementTitle, isLogoutCell: item.isElementWithLogout)
                    cell.selectionStyle = .none
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        view.backgroundColor = .Side100
        
        settingTableView.do {
            $0.register(MyPageToggleTableViewCell.self, forCellReuseIdentifier: "settingToggleTableView")
            $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: "settingTableView")
            $0.rowHeight = self.rowHeight
            $0.isScrollEnabled = false
            $0.separatorColor = .Gray1
            $0.backgroundColor = .Side100
        }
        
        contactImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "MyPageFooterInformation")
        }
    }
    
    private func setLayout() {
        view.addSubviews(navigationBarView, profileView, boxView, settingTableView, contactImageView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(66)
            $0.horizontalEdges.equalToSuperview()
        }
        
        profileView.snp.makeConstraints {
            $0.height.equalTo(view.snp.width).dividedBy(self.profileProportion)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4)
        }
        
        boxView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(self.boxHeight)
        }
        
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(boxView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(self.tableViewBottom)
        }
        
        contactImageView.snp.makeConstraints {
            $0.top.equalTo(settingTableView.snp.bottom)
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
    }
}

extension MyPageViewController {
    func setAbnormalDeviceForLayout(isDeviceAbnormal: Bool) {
        self.isDeviceAbnormal = isDeviceAbnormal
    }
}
