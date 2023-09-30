//
//  TabBarController.swift
//  tellingMe
//
//  Created by 마경미 on 25.04.23.
//

import UIKit

class MainTabBarController: UITabBarController {
    let shadowView = UIView()
    private var viewControllersList: [UIViewController] = []

    override func viewDidLoad() {
        tabBar.frame = CGRect(x: 0, y: view.frame.height - 88, width: view.frame.width, height: 88)
        super.viewDidLoad()
        
        self.delegate = self
        setTabBarAppearance()
        setupTabBarViewControllers()
        setTabBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    func showPushNotification() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "pushNotificationModal") as? PushNotificationModalViewController else { return }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    private func setupTabBarViewControllers() {
        // Use the Storyboard IDs to instantiate the Storyboard-based view controllers
//        let firstViewController = storyboard?.instantiateViewController(withIdentifier: "FirstViewController")
//        let thirdViewController = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController")
//
//        let secondViewController = SecondViewController() // Code-based view controller
//        let fourthViewController = FourthViewController() // Code-based view controller
        
        let homeViewController = HHomeViewController()
        
        let storyboardForAnswerList = UIStoryboard(name: "AnswerList", bundle: nil)
        let stortboardForMyLibrary = UIStoryboard(name: "Library", bundle: nil)
        let stortboardForCommunication = UIStoryboard(name: "Communication", bundle: nil)
        
        let answerListViewController = storyboardForAnswerList.instantiateViewController(withIdentifier: "answerListViewController")
        let myLibraryViewController = stortboardForMyLibrary.instantiateViewController(withIdentifier: "libraryNavigation")
        let communicationViewController = stortboardForCommunication.instantiateViewController(withIdentifier: "communityNavigation")
        
        viewControllersList = [homeViewController, answerListViewController, myLibraryViewController, communicationViewController]
        setViewControllers(viewControllersList.compactMap { $0 }, animated: false)
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
    
    private func setTabBarItems() {
        TabBarItemType.allCases.forEach {
            let tabBarItem = $0.setTabBarItem()
            viewControllersList[$0.pageIndex].tabBarItem = tabBarItem
            viewControllersList[$0.pageIndex].tabBarItem.tag = $0.pageIndex
        }
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.selectedViewController = viewController
    }
}
