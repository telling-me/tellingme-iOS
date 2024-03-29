//
//  MyPageViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import MessageUI
import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class MyPageViewController: EmailFeedbackViewController {
    
    private var userName: String = ""
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
    
    private let navigationBarView = CustomNavigationBarView()
    private let profileView = MyPageProfileView()
    private let boxView = MyPageBoxView()
    private let settingTableView = UITableView()
    private let contactImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
        /// delete UserDefaults!!
        /// and Keychain Too.
        /// 우선 10 부터 시작
        if UserDefaults.standard.integer(forKey: StringLiterals.paidProductId) != -1 {
            UserDefaults.standard.removeObject(forKey: StringLiterals.paidProductId)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadUserName()
//        checkPlusUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollEnableWhenNeeded()
        checkPlusUser()
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
                self?.userName = response.nickname
                self?.profileView.setUserName(newName: response.nickname)
                self?.profileView.setConsecutiveDay(day: response.answerRecord)
                self?.profileView.setUserProfileImage(urlString: response.profileUrl)
                self?.profileView.isUserPremiumUser(isPremium: response.isPremium)
                self?.profileView.setAttributedStringForConsecutiveLabel(day: response.answerRecord)
            }
            .disposed(by: disposeBag)
        
        boxView.mainIconCollectionView.rx.itemSelected
            .bind (onNext: { [weak self] indexPath in
                let index = indexPath.row
                switch index {
                case 0:
                    self?.viewModel.inputs.premiumInAppPurchaseTapped()
                    let premiumViewController = PremiumInformationViewController()
                    self?.navigationController?.pushViewController(premiumViewController, animated: true)
                case 1:
                    self?.viewModel.inputs.tellingMeBootPayPurchaseTapped()
                    let tellingEBookViewController = TellingEBookViewController()
                    self?.navigationController?.pushViewController(tellingEBookViewController, animated: true)
                case 2:
                    self?.viewModel.inputs.faqTapped()
                case 3:
                    self?.viewModel.inputs.myProfileTapped()
                    let settingViewModel = SettingViewModel()
                    let id = settingViewModel.items[0].id
                    let viewController = settingViewModel.items[0].view
                    let storyboard = UIStoryboard(name: "Setting", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: id)
                    self?.navigationController?.pushViewController(vc, animated: true)
                default:
                    break
                }
            })
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
        
        settingTableView.rx.itemSelected
            .bind(onNext: { [weak self] indexPath in
                guard let self else { return }
                self.settingTableView.deselectRow(at: indexPath, animated: true)
                let index = indexPath.row
                switch index {
//                case 1:
//                    let myPageSecurityViewController = MyPageSecurityViewController()
//                    self.navigationController?.pushViewController(myPageSecurityViewController, animated: true)
                case 1:
                    self.viewModel.inputs.termsOfUseTapped()
                case 2:
                    self.viewModel.inputs.privatePolicyTapped()
                case 3:
                    self.viewModel.inputs.feedBackWithMailTapped()
                    self.sendFeedbackMail(userOf: self.userName)
                case 4:
                    self.viewModel.inputs.questionPlantTapped()
                case 5:
                    self.viewModel.inputs.tellingMeInstagramTapped()
                case 6:
                    self.viewModel.inputs.withdrawalTapped()
                    let settingViewModel = SettingViewModel()
                    let id = settingViewModel.items[3].id
                    let viewController = settingViewModel.items[3].view
                    let storyboard = UIStoryboard(name: "Setting", bundle: nil)
                    guard let vc = storyboard.instantiateViewController(withIdentifier: id) ?? viewController as? UIViewController else {
                        return
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                case 7:
                    self.viewModel.inputs.logoutTapped()
                    self.showWarningAlertOfSecurityAllGoneWhenLogOut()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        view.backgroundColor = .Side100
        
        navigationBarView.do {
            $0.setTitle(with: "마이페이지")
        }
        
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
    private func showWarningAlertOfSecurityAllGoneWhenLogOut() {
        if SecurityManager.checkIfAnySecurityIsSet() != false {
            let alert = UIAlertController(title: "로그아웃을 하면 잠금이 풀립니다.", message: "로그아웃을 하면 백업 이메일을 제외한 디바이스의 모든 잠금이 풀립니다. 진행하시겠습니까?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .default)
            let confirmAction = UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
                guard let self else { return }
                self.signout()
            }
            
            alert.addAction(cancelAction)
            alert.addAction(confirmAction)
            present(alert, animated: false)
        } else {
            signout()
        }
    }
    
    private func signout() {
        SignAPI.logout { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                KeychainManager.shared.deleteOnlySecureKeys()
                KeychainManager.shared.logout()
                let signInViewController = SignInViewController()
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                
                sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: signInViewController)
                sceneDelegate.window?.makeKeyAndVisible()
                
                if let bundleId = Bundle.main.bundleIdentifier {
                    print("All UserDefaults are removed.")
                    UserDefaults.standard.removePersistentDomain(forName: bundleId)
                    UserDefaults.setLaunchedBeforeFlag()
                }

            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("토큰 업슴")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func reloadUserName() {
        if let userNameSaved = UserDefaults.standard.string(forKey: StringLiterals.savedUserName) {
            if self.userName == userNameSaved {
                return
            } else {
                profileView.setUserName(newName: userNameSaved, oldName: self.userName)
            }
        }
    }
    
    private func checkPlusUser() {
//        let userDefaults = UserDefaults.standard
//        let isPlusUser = userDefaults.string(forKey: StringLiterals.paidProductId)
//        if isPlusUser != nil {
//            profileView.isUserPremiumUser(isPremium: true)
//        } else {
//            profileView.isUserPremiumUser(isPremium: false)
//        }
    }
    
    private func scrollEnableWhenNeeded() {
        if settingTableView.contentSize.height > settingTableView.frame.size.height {
            settingTableView.isScrollEnabled = true
        } else {
            settingTableView.isScrollEnabled = false
        }
    }
}

extension MyPageViewController {
    func setAbnormalDeviceForLayout(isDeviceAbnormal: Bool) {
        self.isDeviceAbnormal = isDeviceAbnormal
    }
}
