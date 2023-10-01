//
//  TabBarController.swift
//  tellingMe
//
//  Created by 마경미 on 25.04.23.
//

import UIKit

class MainTabBarController: UITabBarController {
    let shadowView = UIView()

    override func viewDidLoad() {
        tabBar.frame = CGRect(x: 0, y: view.frame.height - 88, width: view.frame.width, height: 88)
        super.viewDidLoad()
        
        self.delegate = self
        setTabBarAppearance()
    }

    func showPushNotification() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "pushNotificationModal") as? PushNotificationModalViewController else { return }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    private func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        tabBar.layer.masksToBounds = true
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .Side100
        appearance.shadowImage = nil
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        tabBar.layer.cornerRadius = 32
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
