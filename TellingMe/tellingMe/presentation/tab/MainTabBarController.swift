//
//  TabBarController.swift
//  tellingMe
//
//  Created by 마경미 on 25.04.23.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        tabBar.frame = CGRect(x: 0, y: view.frame.height - 88, width: view.frame.width, height: 88)

        super.viewDidLoad()
        selectedIndex = 1

        tabBar.layer.cornerRadius = 32
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        let shadowView = UIView(frame: tabBar.frame)
//        shadowView.frame = tabBar.bounds
//        print(tabBar)
//        print(shadowView)
//        shadowView.backgroundColor = .white
//        shadowView.layer.cornerRadius = 32
//        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
//        shadowView.layer.shadowOpacity = 1
//        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
//        shadowView.layer.shadowRadius = 20
//        shadowView.layer.masksToBounds = false
//        // clipsToBounds 속성을 false로 설정합니다.
//        tabBar.clipsToBounds = false
//        print(tabBar.superview)
//        tabBar.superview?.insertSubview(shadowView, aboveSubview: tabBar)
        let shadowView = UIView(frame: tabBar.frame)
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = 32
        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowRadius = 20
        shadowView.layer.masksToBounds = false

        self.view.addSubview(shadowView)
        self.view.bringSubviewToFront(self.tabBar)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 88
        tabBarFrame.origin.y = view.frame.size.height - 88
        tabBar.frame = tabBarFrame
    }
}
