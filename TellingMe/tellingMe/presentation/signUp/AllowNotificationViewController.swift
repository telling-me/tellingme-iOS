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
            SignUpData.shared.allowNotification = true
            registerForPushNotifications { [weak self] in
                self?.sendSignUpData()
            }
        } else {
            SignUpData.shared.allowNotification = false
            sendSignUpData()
        }
    }

    func registerForPushNotifications(completion: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                if let token = Messaging.messaging().fcmToken {
                    SignUpData.shared.firebaseToken = token
                    completion() // 토큰 처리 후 completion 호출
                } else {
                    fatalError("푸쉬 알림을 등록할 수 없습니다.")
                }
            }
        }
    }
}
