//
//  SettingTableViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit
import Firebase
import UserNotifications
import RxSwift

class SettingTableViewController: UITableViewController {
    let viewModel = SettingViewModel()
    let disposeBag = DisposeBag()
    @IBOutlet weak var pushSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        self.viewModel.fetchNotificationData()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        self.pushSwitch.isOn = viewModel.isPushAllowed ?? false
//    }

    func checkNotification () {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .denied:
                // 이미 푸시 알림이 거부된 상태이므로 동의를 허용
                self.enablePushNotification()
            case .notDetermined:
                // 푸시 알림 설정이 아직 결정되지 않은 상태이므로 동의를 허용
                self.enablePushNotification()
            default:
                // 알 수 없는 상태
                break
            }
        }
    }

    func enablePushNotification() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "알림 설정", message: "푸시 알림을 받으려면 앱의 설정에서 푸시 알림을 활성화해야 합니다.", preferredStyle: .alert)

            let settingsAction = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
                // iOS의 설정 앱으로 이동
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsURL) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }

            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }

    func bindViewModel() {
        pushSwitch.rx.isOn
            .bind(to: viewModel.pushToggleValue)
            .disposed(by: disposeBag)
        viewModel.pushToggleValue
              .bind(to: pushSwitch.rx.isOn)
              .disposed(by: disposeBag)
        viewModel.pushToggleValue
            .distinctUntilChanged() // 이전 값과 다를 때만 전송
            .subscribe(onNext: { [weak self] value in
                self?.viewModel.postNotification(value)
            }).disposed(by: disposeBag)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
//            let id = viewModel.items[indexPath.row-1].id
//            let viewController = viewModel.items[indexPath.row-1].view
//            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: id) as? PrivacyPolicyViewController else {
//                return
//            }
//            vc.setTag(tag: 0)
//            self.navigationController?.pushViewController(vc, animated: true)
            if let url = URL(string: "https://doana.notion.site/f42ec05972a545ce95231f8144705eae?pvs=4") {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
             }
        case 3:
//            let id = viewModel.items[indexPath.row-1].id
//            let viewController = viewModel.items[indexPath.row-1].view
//            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: id) as? PrivacyPolicyViewController else {
//                return
//            }
//            vc.setTag(tag: 1)
//            self.navigationController?.pushViewController(vc, animated: true)
            if let url = URL(string: "https://doana.notion.site/7cdab221ee6d436781f930442040d556?pvs=4") {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
             }
        case 4:
            if let url = URL(string: "https://doana.notion.site/f7a045872c3b4b02bce5e9f6d6cfc2d8?pvs=4") {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
             }
        case 5:
            let id = viewModel.items[3].id
            let viewController = viewModel.items[3].view
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: id) ?? viewController as? UIViewController else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            self.signout()
        default:
            let id = viewModel.items[indexPath.row-1].id
            let viewController = viewModel.items[indexPath.row-1].view
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: id) ?? viewController as? UIViewController else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
