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
            print("일단 열리잖아요")
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("\(error) 카카오로그인 실패요~~")
                } else {
                    print("카카오로그인 성공")
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
                print("사용자 정보 가져오기 성공")
                guard let user_data = user else { return }
                let request = OauthRequest(socialId: String(user_data.id!))
                LoginAPI.postKakaoOauth(type: "kakao", request: request) { result in
                    switch result {
                    case .success(let response):
                        KeychainManager.shared.save(response!.accessToken, key: "accessToken")
                        KeychainManager.shared.save(response!.refreshToken, key: "refreshToken")
                        self.pushHome()
                    case .failure(let error):
                        switch error {
                        case .errorData(let errorData):
                            self.showToast(message: errorData.message)
                        case .notJoin(let errorResponse):
                            KeychainManager.shared.save(errorResponse.socialId, key: "socialId")
                            KeychainManager.shared.save("kakao", key: "socialLoginType")
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
               let tokenString = String(data: identityToken, encoding: .utf8) {
                KeychainManager.shared.save(tokenString, key: "appleAccessToken")
                LoginAPI.postAppleOauth(type: "apple", token: tokenString, request: OauthRequest(socialId: "")) { result in
                    switch result {
                    case .success(let response):
                        KeychainManager.shared.save(response!.accessToken, key: "accessToken")
                        KeychainManager.shared.save(response!.refreshToken, key: "refreshToken")
                        self.pushHome()
                    case .failure(let error):
                        switch error {
                        case .errorData(let errorData):
                            self.showToast(message: errorData.message)
                        case .notJoin(let errorResponse):
                            KeychainManager.shared.save(errorResponse.socialId, key: "socialId")
                            KeychainManager.shared.save("kakao", key: "socialLoginType")
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