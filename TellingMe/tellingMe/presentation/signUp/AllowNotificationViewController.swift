//
//  AllowNotificationViewController.swift
//  tellingMe
//
//  Created by 마경미 on 20.04.23.
//

import UIKit

class AllowNotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func pushHome() {
        print("push 좀 해")
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
        } else {
            SignUpData.shared.allowNotification = false
        }
        self.sendSignUpData()
    }
}
