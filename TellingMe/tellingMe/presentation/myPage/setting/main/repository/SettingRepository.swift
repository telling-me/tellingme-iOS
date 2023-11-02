//
//  SettingRepository.swift
//  tellingMe
//
//  Created by 마경미 on 02.06.23.
//

import Foundation
import UIKit
import AuthenticationServices

extension WithdrawalViewController {
    func withDrawalUser(authCode: String = "") {
        let request = WithdrawalRequest(authorizationCode: authCode)
        SignAPI.withdrawalUser(request: request) { result in
            switch result {
            case .success:
                KeychainManager.shared.deleteAll()
                let signInViewController = SignInViewController()
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                
                sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: signInViewController)
                sceneDelegate.window?.makeKeyAndVisible()

                if let bundleId = Bundle.main.bundleIdentifier {
                    print("All UserDefaults are removed.")
                    UserDefaults.standard.removePersistentDomain(forName: bundleId)
                    UserDefaults.setLaunchedBeforeFlag()
                }
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("토큰 업슴")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            if  let authCode = appleIDCredential.authorizationCode,
               let authCodeString = String(data: authCode, encoding: .utf8) {
                withDrawalUser(authCode: authCodeString)
            }

            // 언제 쓰이는거지?
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            print(passwordCredential)

        default:
            break
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? UIWindow()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.showToast(message: "애플 로그인에 실패하였습니다.")
    }
}

extension SettingTableViewController {
    func signout() {
        SignAPI.logout { result in
            switch result {
            case .success:
                KeychainManager.shared.logout()
                let signInViewController = SignInViewController()
                self.navigationController?.pushViewController(signInViewController, animated: true)
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("토큰 업슴")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }
}
