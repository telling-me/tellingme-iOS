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
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        performAutoLogin()
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
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
func performAutoLogin() {
    guard KeychainManager.shared.load(key: "accessToken") != nil else {
        return
    }
    guard KeychainManager.shared.load(key: "refreshToken") != nil else {
        return
    }
    showHome()
}
    
    func showHome() {
        // 로그인 화면의 뷰 컨트롤러를 생성합니다.
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }

        // MainTabBar의 두 번째 탭으로 이동합니다.
        tabBarController.selectedIndex = 1

        // 로그인 화면을 표시할 윈도우를 가져옵니다.
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        // 로그인 화면을 윈도우의 rootViewController로 설정합니다.
        window.rootViewController = tabBarController

        // 윈도우를 활성화하여 로그인 화면을 표시합니다.
        window.makeKeyAndVisible()
    }
}
