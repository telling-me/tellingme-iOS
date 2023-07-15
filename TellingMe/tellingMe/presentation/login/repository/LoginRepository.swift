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
import Alamofire

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func callKakaoAPI() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("\(error) 카카오로그인 실패요~~")
                } else {
                    self.getUserInfo(oauthToekn: oauthToken!)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print("\(error) 카카오로그인 실패요~~")
                } else {
                    self.getUserInfo(oauthToekn: oauthToken!)
                }
            }
        }
    }

    func getUserInfo(oauthToekn: OAuthToken) {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print("\(error) 사용자 정보 가져오기 실패")
            } else {
                guard let user_data = user else { return }
                KeychainManager.shared.save("kakao", key: Keys.socialLoginType.rawValue)
                KeychainManager.shared.save(String(user_data.id!), key: Keys.socialId.rawValue)
                let request = OauthRequest(socialId: String(user_data.id!))
                LoginAPI.postKakaoOauth(type: "kakao", request: request) { result in
                    switch result {
                    case .success(let response):
                        KeychainManager.shared.save(response!.accessToken, key: Keys.accessToken.rawValue)
                        KeychainManager.shared.save(response!.refreshToken, key: Keys.refreshToken.rawValue)
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
                KeychainManager.shared.save("apple", key: Keys.socialLoginType.rawValue)
                KeychainManager.shared.save(tokenString, key: Keys.appleToken.rawValue)
                LoginAPI.postAppleOauth(type: "apple", token: tokenString, request: OauthRequest(socialId: nil)) { result in
                    switch result {
                    case .success(let response):
                        KeychainManager.shared.save(response!.accessToken, key: Keys.accessToken.rawValue)
                        KeychainManager.shared.save(response!.refreshToken, key: Keys.refreshToken.rawValue)
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
