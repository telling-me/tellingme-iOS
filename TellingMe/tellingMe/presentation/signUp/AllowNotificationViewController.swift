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
        // 로그인 화면의 뷰 컨트롤러를 생성합니다.
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }

        // MainTabBar의 두 번째 탭으로 이동합니다.
        tabBarController.selectedIndex = 1

        // 로그인 화면을 윈도우의 rootViewController로 설정합니다.
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    @IBAction func clickAllow(_ sender: UIButton) {
        if sender.tag == 0 {
            registerForNotification() {
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
                    } else {
                        DispatchQueue.main.async {
                            self.showToast(message: "푸시 알림을 등록할 수 없습니다.")
                        }
                        SignUpData.shared.allowNotification = false
                    }
                } else {
                    print("푸시 알림 거절하였습니다.")
                    SignUpData.shared.allowNotification = false
                }
                if let error = error {
                    DispatchQueue.main.async {
                        self.showToast(message: "푸시 알림을 등록할 수 없습니다.")
                    }
                    SignUpData.shared.allowNotification = false
                }
                completion()
            }
    }
}
