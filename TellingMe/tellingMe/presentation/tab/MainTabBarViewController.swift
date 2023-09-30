////
////  MainTabBarViewController.swift
////  tellingMe
////
////  Created by KYUBO A. SHIM on 2023/09/23.
////
//
//import UIKit
//
//import SnapKit
//
//final class MainTabBarViewController: UITabBarController {
//
//    private var tabViewControllers: [UIViewController] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
//
//}
//
//extension MainTabBarViewController {
//
//    private func setTabBarItems() {
//
//        self.tabViewControllers = [
//            Home
//
//        ]
//
//
//        tabs = [
//            HomeViewController(),
//            MyProjectViewController()
//        ]
//
//        TabBarItemType.allCases.forEach {
//            let tabBarItem = $0.setTabBarItem()
//            tabs[$0.rawValue].tabBarItem = tabBarItem
//            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
//        }
//
//        setViewControllers(tabs, animated: false)
//    }
//
//    private func setTabBarUI() {
//        UITabBar.clearShadow()
//        tabBar.layer.masksToBounds = false
//        tabBar.layer.shadowOpacity = 0.2
//        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
//        tabBar.layer.shadowRadius = 0.7
//        tabBar.tintColor = .blue400
//    }
//}
