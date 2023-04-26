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
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "home") as? HomeViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
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
