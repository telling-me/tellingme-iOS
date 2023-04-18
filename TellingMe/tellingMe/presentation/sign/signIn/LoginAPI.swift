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
                print("사용자 정보 가져오기 성공")
                guard let user_data = user else { return }
                let parameter = OauthRequest(socialId: String(user_data.id!))
                let urlComponents = URLComponents(string: Bundle.main.APIURL + "/api/oauth/kakao")!
                let request = AF.request(urlComponents.url!, method: .post, parameters: parameter)
                request.validate().responseDecodable(of: OauthResponse.self) { (res) in
                    print(res)
                }
            }
        }
    }

    func callAppleAPI() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        print(request)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        print("request 한거맞아용?")
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authString = String(data: authorizationCode, encoding: .utf8),
                let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
            }
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
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
