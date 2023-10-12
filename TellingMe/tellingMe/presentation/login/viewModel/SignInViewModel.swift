//
//  SignInViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 09.09.23.
//

import Foundation
import RxSwift
import RxCocoa
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import Moya

struct OnBoarding {
    let title: String
    let highLightTitle: String
    let subTitle: String
    let image: String
}

protocol SignInViewModelOutputs {
    var signInSubject: BehaviorSubject<SignInResponse> { get }
    var signUpSubject: BehaviorSubject<SignInErrorResponse> { get }
    var toastSubject: BehaviorSubject<String> { get }
}

protocol SignInViewModelType {
    var outputs: SignInViewModelOutputs { get }
}

final class SignInViewModel: SignInViewModelType, SignInViewModelOutputs {
    public var currentPage: Int = 0
    public let items: Observable<[OnBoarding]> = Observable.just([
        OnBoarding(title: "하루 한 번,\n질문에 답변하며 나를 깨닫는 시간", highLightTitle: "나를 깨닫는 시간", subTitle: "매일 오전 6시에 배달되는 질문에\n펜 아이콘을 눌러 답변해 보아요.", image: "OnBoarding1"),
        OnBoarding(title: "매일 매일,\n나의 진솔한 생각이 쌓여가요", highLightTitle: "진솔한 생각", subTitle: "꾸준한 기록은 나에 대해\n더 많이 알게 해줘요.", image: "OnBoarding2"),
        OnBoarding(title: "나와 비슷한 사람들과\n질문에 대한 생각을 나누어요", highLightTitle: "나와 비슷한 사람들", subTitle: "공유하기 버튼을 눌러\n모두의 공간에 나의 글을 공유해 보아요.", image: "OnBoarding3")
    ])

    public var itemCount: Int {
        return 3
    }
    
    // output
    var signInSubject: BehaviorSubject<SignInResponse> = BehaviorSubject(value: .init(accessToken: "", refreshToken: "", socialId: ""))
    var signUpSubject: BehaviorSubject<SignInErrorResponse> = BehaviorSubject(value: .init(socialId: "", socialLoginType: ""))
    var toastSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    private let disposeBag = DisposeBag()
    var outputs: SignInViewModelOutputs { return self }
    
    func signIn(type: String, oauthToken: String) {
        SignAPI.signIn(type: type, token: oauthToken)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                KeychainManager.shared.save(response.accessToken, key: Keys.accessToken.rawValue)
                KeychainManager.shared.save(response.refreshToken, key: Keys.refreshToken.rawValue)
                KeychainManager.shared.save(response.socialId, key: Keys.socialId.rawValue)
                self.signInSubject.onNext(response)
            }, onError: { error in
                switch error {
                case APIError.errorData(let errorData):
                    self.toastSubject.onNext(errorData.message)
                case APIError.other(let error):
                    let error = error as? MoyaError
                    if let data = error?.response?.data {
                        if let errorResponse = try?  JSONDecoder().decode(SignInErrorResponse.self, from: data) {
                            KeychainManager.shared.save(errorResponse.socialId, key: Keys.socialId.rawValue)
                            KeychainManager.shared.save(errorResponse.socialLoginType, key: Keys.socialLoginType.rawValue)
                            self.signUpSubject.onNext(errorResponse)
                        } else {
                            self.toastSubject.onNext("로그인 정보를 찾을 수 없습니다.")
                        }
                    } else {
                        
                    }
                default:
                    self.toastSubject.onNext("로그인을 할 수 없습니다.")
                }
            }).disposed(by: disposeBag)
    }
}

extension SignInViewModel {
    func callKakaoAPI() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if error != nil {
                    self.toastSubject.onNext("카카오톡을 이용할 수 없습니다.")
                } else {
                    guard let oauthToken = oauthToken else {
                        return
                    }
                    KeychainManager.shared.save("kakao", key: Keys.socialLoginType.rawValue)
                    KeychainManager.shared.save(oauthToken.accessToken, key: Keys.idToken.rawValue)
                    self.signIn(type: "kakao", oauthToken: oauthToken.accessToken)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if error != nil {
                    self.toastSubject.onNext("카카오톡을 이용할 수 없습니다.")
                } else {
                    guard let oauthToken = oauthToken else {
                        return
                    }
                    KeychainManager.shared.save("kakao", key: Keys.socialLoginType.rawValue)
                    KeychainManager.shared.save(oauthToken.accessToken, key: Keys.idToken.rawValue)
                    self.signIn(type: "kakao", oauthToken: oauthToken.accessToken)
                }
            }
        }
    }
}
