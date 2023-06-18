//
//  AllowNotificationViewController.swift
//  tellingMe
//
//  Created by 마경미 on 20.04.23.
//

import UIKit
import Firebase

class AllowNotificationViewController: UIViewController, MessagingDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//        Messaging.messaging().delegate = self
    }

    func pushHome() {
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }

        // MainTabBar의 두 번째 탭으로 이동합니다.
        tabBarController.selectedIndex = 1

        // MainTabBar를 present 합니다.
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }

    @IBAction func clickAllow(_ sender: UIButton) {
        if sender.tag == 0 {
            registerForNotification() {
                print("끝이야?")
                self.sendSignUpData()
            }
        } else {
            SignUpData.shared.allowNotification = false
            self.sendSignUpData()
        }
    }

    func registerForNotification(completion: @escaping () -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { (granted, error) in
                if granted {
                    if let token = Messaging.messaging().fcmToken {
                        SignUpData.shared.allowNotification = true
                        SignUpData.shared.firebaseToken = token
                        completion()
                    } else {
                        self.showToast(message: "푸시 알림을 등록할 수 없습니다.")
                        SignUpData.shared.allowNotification = false
                        completion()
                    }
                } else {
                    print("푸시 알림 거절하였습니다.")
                    SignUpData.shared.allowNotification = false
                }
                if let error = error {
                    self.showToast(message: "동의 시에 문제가 생겼습니다.")
                    SignUpData.shared.allowNotification = false
                }
                completion()
            }
    }
}
