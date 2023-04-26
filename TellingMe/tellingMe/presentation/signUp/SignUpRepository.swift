//
//  SignRepository.swift
//  tellingMe
//
//  Created by 마경미 on 26.04.23.
//

import Foundation

extension AllowNotificationViewController {
    func sendSignUpData() {
        let request = SignUpRequest(allowNotification: SignUpData.shared.allowNotification, nickname: SignUpData.shared.nickname, purpose: SignUpData.shared.purpose, job: SignUpData.shared.job, jobInfo: SignUpData.shared.jobInfo, gender: SignUpData.shared.gender, birthDate: SignUpData.shared.birthDate, mbti: SignUpData.shared.mbti, socialId: KeychainManager.shared.load(key: "socialId") ?? "", socialLoginType: KeychainManager.shared.load(key: "socialLoginType") ?? "")
        SignAPI.postSignUp(request: request) { result in
            switch result {
            case .success(let response):
                print("success야", response)
                
            case .failure(let error):
                print("error야", error)
            }
        }
    }

    func login() {
        guard let loginType = KeychainManager.shared.load(key: "socialLoginType") else { return }
        guard let socialId = KeychainManager.shared.load(key: "socialId") else { return }
        SignAPI.postKakaoOauth(type: loginType, request: OauthRequest(socialId: socialId)) { result in
            switch result {
            case .success:
                self.pushHome()
            case .failure:
                print("kakao 실패욤!")
            }
        }
    }
}
