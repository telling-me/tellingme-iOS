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
        checkFeedbackDate()
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
    
    func checkFeedbackDate() {
        if let currentDateString = Date().getQuestionDate(),
           let currentDate = currentDateString.stringToDate() {
            let weekday = Calendar.current.component(.weekday, from: currentDate)
            
            if weekday == 2 {
                if let lastDate =  UserDefaults.standard.string(forKey: "lastFeedbackDate") {
                    guard currentDateString != lastDate else {
                        return
                    }
                }
                showFeedback()
                UserDefaults.standard.setValue(currentDateString, forKey: "lastFeedbackDate")
            } else {
                return
            }
        } else {
            return
        }
    }
    
    func showFeedback() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            let vc = UINavigationController(rootViewController: FeedbackViewController())
            vc.isNavigationBarHidden = true

            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.selectedViewController = viewController
    }
}
