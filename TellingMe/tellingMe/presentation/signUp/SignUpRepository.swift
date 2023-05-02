//
//  SignRepository.swift
//  tellingMe
//
//  Created by 마경미 on 26.04.23.
//

import Foundation

extension AllowNotificationViewController {
    func sendSignUpData() {
        guard let loginType = KeychainManager.shared.load(key: "socialLoginType") else { return }
        let request = SignUpRequest(allowNotification: SignUpData.shared.allowNotification, nickname: SignUpData.shared.nickname, purpose: SignUpData.shared.purpose, job: SignUpData.shared.job, jobInfo: SignUpData.shared.jobInfo, gender: SignUpData.shared.gender, birthDate: SignUpData.shared.birthDate, mbti: SignUpData.shared.mbti, socialId: KeychainManager.shared.load(key: "socialId") ?? "", socialLoginType: loginType)
        LoginAPI.postSignUp(request: request) { result in
            switch result {
            case .success:
                self.login(type: loginType)
            case .failure(let error):
                print("error야", error)
            }
        }
    }

    func login(type: String) {
        guard let socialId = KeychainManager.shared.load(key: "socialId") else { return }
        let request = OauthRequest(socialId: socialId)
        LoginAPI.postKakaoOauth(type: type, request: request) { result in
            switch result {
            case .success(let response):
                self.pushHome()
                KeychainManager.shared.save(response!.accessToken, key: "accessToken")
                KeychainManager.shared.save(response!.refreshToken, key: "refreshToken")
            case .failure(let error):
                print("회원가입 다시", error)
            }
        }
    }
}
