//
//  PushNotificationModalViewController.swift
//  tellingMe
//
//  Created by 마경미 on 12.07.23.
//

import UIKit
import Firebase

class PushNotificationModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.view.backgroundColor = .clear
    }

    func registerForNotification(completion: @escaping () -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { (granted, error) in
                if granted {
                }

                if let error = error {
                    DispatchQueue.main.async {
                        self.showToast(message: "푸시 알림을 등록할 수 없습니다.")
                    }
                }
                completion()
            }
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        registerForNotification {
            if let token = Messaging.messaging().fcmToken {
                KeychainManager.shared.save(token, key: Keys.firebaseToken.rawValue)
            }
            self.sendFirebaseToken()
        }
        self.sendNotification(tag: sender.tag)
        self.dismiss(animated: true)
    }
}
