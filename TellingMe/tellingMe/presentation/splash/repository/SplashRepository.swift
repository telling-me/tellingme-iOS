//
//  SplashRepository.swift
//  tellingMe
//
//  Created by 마경미 on 14.06.23.
//

import Foundation
import UIKit
import RxSwift

extension SplashViewController {
    func performAutoLogin(type: String, socialId: String) -> Observable<Bool> {
        return Observable.create { observer in
            SignAPI.autologin(type: type, request: AutologinRequest(socialId: socialId)) { result in
                switch result {
                case .success(let response):
                    KeychainManager.shared.save(response!.accessToken, key: Keys.accessToken.rawValue)
                    KeychainManager.shared.save(response!.refreshToken, key: Keys.refreshToken.rawValue)
                    observer.onNext(true)
                case .failure(let error):
                    observer.onNext(false)
                }
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func performAutoLoginAndNavigate() {
        if UserDefaults.isFirstLaunch() {
            self.showSignIn()
            KeychainManager.shared.deleteAllExceptSecureKeys()
            return
        }

        guard let type = KeychainManager.shared.load(key: Keys.socialLoginType.rawValue),
              let socialId = KeychainManager.shared.load(key: Keys.socialId.rawValue) else {
            self.showSignIn()
            return
        }
        performAutoLogin(type: type, socialId: socialId)
            .observe(on: MainScheduler.instance) // UI 스레드에서 실행
            .subscribe(onNext: { [weak self] isLogined in
                if isLogined {
                    self?.checkSecurity()
                } else {
                    self?.showSignIn()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Presentation Helpers
extension SplashViewController {
    
    func checkSecurity() {
        switch SecurityManager.checkSecurityPermission() {
        case .unlocked:
            showHome()
        case .withPassword, .withBiometry:
            showSecurityView()
        }
    }
    
    func showSecurityView() {
        let securityViewController = SecurityViewController()
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = securityViewController
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    func showHome() {
        // 로그인 화면의 뷰 컨트롤러를 생성합니다.
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }
        
        // MainTabBar의 두 번째 탭으로 이동합니다.
        tabBarController.selectedIndex = 0
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: tabBarController)
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    func showSignIn() {
        let signInViewController = SignInViewController()
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: signInViewController)
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
