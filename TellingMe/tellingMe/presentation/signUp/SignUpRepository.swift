//
//  SignRepository.swift
//  tellingMe
//
//  Created by 마경미 on 26.04.23.
//

import Foundation

extension GetBirthdayViewController {
    func sendSignUpData() {
        guard let loginType = KeychainManager.shared.load(key: Keys.socialLoginType.rawValue) else {
            self.showToast(message: "소셜 로그인을 확인할 수 없습니다.")
            return }
        guard let socialId = KeychainManager.shared.load(key: Keys.socialId.rawValue) else {
            self.showToast(message: "소셜 로그인을 확인할 수 없습니다.")
            return }
        let request = SignUpRequest(nickname: SignUpData.shared.nickname, purpose: SignUpData.shared.purpose, job: SignUpData.shared.job, jobInfo: SignUpData.shared.jobInfo, gender: SignUpData.shared.gender, birthDate: SignUpData.shared.birthDate, socialId: socialId, socialLoginType: loginType)

        LoginAPI.postSignUp(request: request) { result in
            switch result {
            case .success:
                self.login(type: loginType)
            case .failure(let error):
                switch error {
                case let .errorData(errorData):
                    self.showToast(message: errorData.message)
                default:
                    print(error)
                }
            }
        }
    }

    func login(type: String) {
        if type == "kakao" {
            guard let socialId = KeychainManager.shared.load(key: Keys.socialId.rawValue) else { return }
            let request = OauthRequest(socialId: socialId)
            LoginAPI.postKakaoOauth(type: "kakao", request: request) { result in
                switch result {
                case .success(let response):
                    self.pushHome()
                    KeychainManager.shared.save(response!.accessToken, key: Keys.accessToken.rawValue)
                    KeychainManager.shared.save(response!.refreshToken, key: Keys.refreshToken.rawValue)
                case .failure(let error):
                    switch error {
                    case let .errorData(errorData):
                        self.showToast(message: errorData.message)
                    default:
                        print(error)
                    }
                }
            }
        } else if type == "apple" {
            guard let token = KeychainManager.shared.load(key: Keys.appleToken.rawValue) else { return }
            guard let socialId = KeychainManager.shared.load(key: Keys.socialId.rawValue) else {
                return
            }
            let request = OauthRequest(socialId: socialId)
            LoginAPI.postAppleOauth(type: "apple", token: token, request: request) { result in
                switch result {
                case .success(let response):
                    self.pushHome()
                    KeychainManager.shared.save(response!.accessToken, key: Keys.accessToken.rawValue)
                    KeychainManager.shared.save(response!.refreshToken, key: Keys.refreshToken.rawValue)
                case .failure(let error):
                    switch error {
                    case let .errorData(errorData):
                        self.showToast(message: errorData.message)
                    default:
                        print(error)
                    }
                }
            }
        }
    }
}
