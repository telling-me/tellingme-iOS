//
//  SceneDelegate.swift
//  tellingMe
//
//  Created by 마경미 on 08.03.23.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var isOpenedFlagForBackgroundTask = false
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
//        
//        let storyboard = UIStoryboard(name: "Splash", bundle: nil) // 변경된 부분: "Main" 스토리보드로 설정
//        if let initialViewController = storyboard.instantiateInitialViewController() {
//            let window = UIWindow(windowScene: scene)
//            window.rootViewController = initialViewController
//            self.window = window
//            window.makeKeyAndVisible()
//        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        showSecureImageForBackgroundStatus(isBackground: false)
        print("Re-Called Check")
        NotificationCenter.default.post(name: Notification.Name("RefreshHomeView"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("RefreshAnimation"), object: nil)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        showSecureImageForBackgroundStatus(isBackground: true)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        if isOpenedFlagForBackgroundTask == false {
            isOpenedFlagForBackgroundTask.toggle()
            return
        }
        
        /// 구독하지 않은 유저는 0 이고, 구독한 유저는 10부터 존재한다.
        if UserDefaults.standard.integer(forKey: StringLiterals.paidProductId) == 0 {
            return
        }
        
        if SecurityManager.checkSecurityPermission() == .unlocked {
            return
        } else {
            let elapsedBackgroundTime = UserDefaults.standard.double(forKey: StringLiterals.backgroundStayingTime)
            let currentTime = Date().timeIntervalSince1970
            let difference = currentTime - elapsedBackgroundTime
            
            /// 백그라운드에서 30분 경과시, 호출된다.
            if difference >= 1800 {
                presentSecureViewController()
            }
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        showSecureImageForBackgroundStatus(isBackground: true)
        
        /// 구독하지 않은 유저는 0 이고, 구독한 유저는 10부터 존재한다.
        if UserDefaults.standard.integer(forKey: StringLiterals.paidProductId) == 0 {
            return
        }
        
        if SecurityManager.checkSecurityPermission() == .unlocked {
            return
        } else {
            let currentTime = Date().timeIntervalSince1970
            UserDefaults.standard.set(currentTime, forKey: StringLiterals.backgroundStayingTime)
        }
    }
}

//extension SceneDelegate {
//    
//    private func presentSecureViewController() {
//        let secureViewController = SecurityViewController()
//        secureViewController.modalPresentationStyle = .overFullScreen
//        window?.rootViewController?.present(secureViewController, animated: false)
//    }
//    
//    private func showSecureImageForBackgroundStatus(isBackground: Bool) {
//        let imageTagNumber: Int = -20
//        let backgroundView = window?.viewWithTag(imageTagNumber)
//        
//        if isBackground != false {
//            if backgroundView == nil {
//                let backgroundImageView = AppBackgroundView()
//                backgroundImageView.frame = window!.frame
//                backgroundImageView.tag = imageTagNumber
//                window?.addSubview(backgroundImageView)
//            }
//        } else {
//            if let backgroundView {
//                backgroundView.removeFromSuperview()
//            }
//        }
//    }
//}
