//
//  TabBarController.swift
//  tellingMe
//
//  Created by 마경미 on 25.04.23.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.layer.cornerRadius = 32
        self.tabBar.layer.masksToBounds = true
        selectedIndex = 1
        
        // 로그인 되어 있는 경우
        let homeViewController = HomeViewController()
        let moreViewController = UIViewController()
        let viewController = UIViewController()

             let controllers = [moreViewController, homeViewController, viewController]

             self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }

             self.selectedIndex = 1 // 처음 선택된 탭 설정
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 88
        tabBarFrame.origin.y = view.frame.size.height - 88
        tabBar.frame = tabBarFrame
    }
}
