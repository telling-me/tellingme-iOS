//
//  LoginAPI.swift
//  tellingMe
//
//  Created by 마경미 on 12.04.23.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import Moya

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func callKakaoAPI() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("\(error)")
                } else {
                    guard let oauthToken = oauthToken else {
                        return
                    }
                    KeychainManager.shared.save(oauthToken.accessToken, key: Keys.idToken.rawValue)
                    self.login(type: "kakao", oauthToken: oauthToken.accessToken)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print("\(error)")
                } else {
                    guard let oauthToken = oauthToken else {
                        return
                    }
                    KeychainManager.shared.save(oauthToken.accessToken, key: Keys.idToken.rawValue)
                    self.login(type: "kakao", oauthToken: oauthToken.accessToken)
                }
            }
        }
    }

    func login(type: String, oauthToken: String) {
        LoginAPI.signIn(type: type, token: oauthToken) { result in
            switch result {
            case .success(let response):
                KeychainManager.shared.save(response!.accessToken, key: Keys.accessToken.rawValue)
                KeychainManager.shared.save(response!.refreshToken, key: Keys.refreshToken.rawValue)
                KeychainManager.shared.save(response!.socialId, key: Keys.socialId.rawValue)
                self.pushHome()
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .notJoin(let response):
                    KeychainManager.shared.save(response.socialId, key: Keys.socialId.rawValue)
                    KeychainManager.shared.save(response.socialLoginType, key: Keys.socialLoginType.rawValue)
                    self.pushSignUp()
                default:
                    print(error)
                }
            }
        }
    }

    func callAppleAPI() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            if let identityToken = appleIDCredential.identityToken,
               let authCode = appleIDCredential.authorizationCode,
               let tokenString = String(data: identityToken, encoding: .utf8),
               let authCodeString = String(data: authCode, encoding: .utf8) {
                KeychainManager.shared.save(tokenString, key: Keys.idToken.rawValue)
                self.login(type: "apple", oauthToken: tokenString)
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
        print(error, "error인데용")
    }
}
