//
//  SplashRepository.swift
//  tellingMe
//
//  Created by 마경미 on 14.06.23.
//

import Foundation
import UIKit

extension SplashViewController {
    func performAutoLogin() {
        guard let type = KeychainManager.shared.load(key: Keys.socialLoginType.rawValue) else {
            showLogin()
            return
        }
        if type == "kakao" {
            guard let socialId = KeychainManager.shared.load(key: Keys.socialId.rawValue) else {
                showLogin()
                return
            }
            let request = OauthRequest(socialId: socialId)
            LoginAPI.postKakaoOauth(type: "kakao", request: request) { result in
                switch result {
                case .success(let response):
                    KeychainManager.shared.save(response!.accessToken, key: Keys.accessToken.rawValue)
                    KeychainManager.shared.save(response!.refreshToken, key: Keys.refreshToken.rawValue)
                    self.showHome()
                case .failure(let error):
                    self.showLogin()
                }
            }
        } else if type == "apple" {
            guard let token = KeychainManager.shared.load(key: Keys.appleToken.rawValue) else {
                showLogin()
                return
            }
            guard let socialId = KeychainManager.shared.load(key: Keys.socialId.rawValue) else {
                showLogin()
                return
            }
            LoginAPI.postAppleOauth(type: "apple", token: token, request: OauthRequest(socialId: socialId)) { result in
                switch result {
                case .success(let response):
                    KeychainManager.shared.save(response!.accessToken, key: Keys.accessToken.rawValue)
                    KeychainManager.shared.save(response!.refreshToken, key: Keys.refreshToken.rawValue)
                    self.showHome()
                case .failure(let error):
                    self.showLogin()
                }
            }
        }
    }

    func showHome() {
        // 로그인 화면의 뷰 컨트롤러를 생성합니다.
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }

        // MainTabBar의 두 번째 탭으로 이동합니다.
        tabBarController.selectedIndex = 1

        // 로그인 화면을 윈도우의 rootViewController로 설정합니다.
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func showLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "login") as? LoginViewController else {
            return
        }

        guard let window = UIApplication.shared.windows.first else {
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
