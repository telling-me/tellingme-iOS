//
//  SettingTableViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit
import Firebase
import UserNotifications

class SettingTableViewController: UITableViewController {
    let viewModel = SettingViewModel()
    @IBOutlet weak var pushSwitch: UISwitch!

    override func viewWillAppear(_ animated: Bool) {
        self.getisAllowedNotification()
    }

    func checkNotification () {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .denied:
                // 이미 푸시 알림이 거부된 상태이므로 동의를 허용
                self.enablePushNotification()
            case .notDetermined:
                // 푸시 알림 설정이 아직 결정되지 않은 상태이므로 동의를 허용
                self.enablePushNotification()
            @unknown default:
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
    
    func getFirebaseToken() -> String {
        guard let token = Messaging.messaging().fcmToken else {
            fatalError("푸쉬 알림을 등록할 수 없습니다.")
        }

        return token
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func toggleSwitch(_ sender: UISwitch) {
        self.postisAllowedNotification()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        } else if indexPath.row == 5 {
            self.signout()
        } else {
            let id = viewModel.items[indexPath.row-1].id
            let viewController = viewModel.items[indexPath.row-1].view
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: id) ?? viewController as? UIViewController else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
