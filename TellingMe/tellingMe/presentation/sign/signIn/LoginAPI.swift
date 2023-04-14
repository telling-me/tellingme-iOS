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
import Moya

extension LoginViewController {
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
                print("사용자 정보 가져오기 성공")
                guard let user_data = user else { return }
                let request = OauthRequest(socialId: String(user_data.id!))
                SignAPI.postOauth(type: "kakao", request: request) { result in
                    switch result {
                    case .success(let response):
                        print("success야", response)
                    case .failure(let error):
                        if let error = error as? OauthErrorResponse {
                            self.pushSignUp()
                            KeychainManager.shared.save(error.socialId, key: "socialId")
                            KeychainManager.shared.save("kakao", key: "socialLoginType")
                        }
                    }
                }
            }
        }
    }

}
