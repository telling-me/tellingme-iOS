//
//  TabBarController.swift
//  tellingMe
//
//  Created by 마경미 on 25.04.23.
//

import UIKit

class MainTabBarController: UITabBarController {
    let shadowView = UIView()

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBar.isHidden = false
//    }

    override func viewDidLoad() {
        tabBar.frame = CGRect(x: 0, y: view.frame.height - 88, width: view.frame.width, height: 88)
        super.viewDidLoad()

        self.delegate = self
        tabBar.layer.cornerRadius = 32
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

//        shadowView.frame = tabBar.frame
//        shadowView.backgroundColor = .white
//        shadowView.layer.cornerRadius = 32
//        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
//        shadowView.layer.shadowOpacity = 1
//        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
//        shadowView.layer.shadowRadius = 20
//        shadowView.layer.masksToBounds = false
//
//        addShadowView()
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        var tabBarFrame = tabBar.frame
//        tabBarFrame.size.height = 88
//        tabBarFrame.origin.y = view.frame.size.height - 88
//        tabBar.frame = tabBarFrame
//    }

    func showPushNotification() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "pushNotificationModal") as? PushNotificationModalViewController else { return }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.selectedViewController = viewController
    }
//    func removeShadowView() {
//        shadowView.removeFromSuperview()
//    }
//
//    func addShadowView() {
//        self.view.addSubview(shadowView)
//        self.view.bringSubviewToFront(self.tabBar)
//    }
}
