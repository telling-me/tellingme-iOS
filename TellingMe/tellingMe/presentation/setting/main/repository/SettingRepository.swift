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
        LoginAPI.withdrawalUser(request: request) { result in
            switch result {
            case .success:
                KeychainManager.shared.deleteAll()
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                guard let vc = storyboard.instantiateViewController(identifier: "login") as? LoginViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
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
    func getisAllowedNotification() {
        UserAPI.getisAllowedNotification { result in
            switch result {
            case .success(let response):
                self.viewModel.isPushAllowed = response!.allowNotification
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    fatalError("토큰이 없습니다")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }

    func postNotification() {
        let request = AllowedNotificationRequest(notificationStatus: self.pushSwitch.isOn)
        UserAPI.postNotification(request: request) { result in
            switch result {
            case .success(let response):
                if response!.allowNotification {
                    self.checkNotification()
                }
                self.pushSwitch.isOn = response!.allowNotification ?? false
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    fatalError("토큰이 없습니다")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }

    func postPushToken() {
        guard let token = self.getFirebaseToken() else {
            self.showToast(message: "푸쉬 알림 설정에 실패하였습니다.")
            self.pushSwitch.isOn = false
            return
        }
        let request = FirebaseTokenRequest(pushToken: token)
        UserAPI.postFirebaseToken(request: request) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                self.showToast(message: "푸시 알림 설정에 실패하였습니다.")
            }
        }
    }

    func signout() {
        LoginAPI.logout { result in
            switch result {
            case .success:
                KeychainManager.shared.deleteAll()
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                guard let vc = storyboard.instantiateViewController(identifier: "login") as? LoginViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
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
