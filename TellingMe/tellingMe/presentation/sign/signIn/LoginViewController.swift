//
//  ViewController.swift
//  tellingMe
//
//  Created by 마경미 on 08.03.23.
//

import UIKit
import AuthenticationServices
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import Moya

@IBDesignable
class LoginViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet var labels: [UILabel]!

    @objc
    func clickKakaoLogin() {
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

    func pushSignUp() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "signUp")as? SignUpViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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

    @objc
    func clickAppleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLoginButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        labelAnimate()
    }

    func setUI() {
        gradientView.frame = CGRect(x: 0, y: 0, width: 285, height: 238)
        gradientView.setShadow()
        gradientView.setGradient(color1: UIColor(red: 0.992, green: 0.859, blue: 0.573, alpha: 1), color2: UIColor(red: 0.82, green: 0.992, blue: 1, alpha: 1))
    }

    func setLoginButtons() {
        let kakaoButton: UIButton = {
            let button = LoginButton()
            button.addTarget(self, action: #selector(clickKakaoLogin), for: .touchDown)
            button.initializeLabel(name: "카카오", color: UIColor(red: 0.996, green: 0.898, blue: 0, alpha: 1))
            return button
        }()

        let appleButton: UIButton = {
            let button = LoginButton()
            button.addTarget(self, action: #selector(clickAppleLogin), for: .touchDown)
            button.initializeLabel(name: "Apple", color: UIColor.black)
            return button
        }()

        loginStackView.addArrangedSubview(kakaoButton)
        loginStackView.addArrangedSubview(appleButton)
        loginStackView.layoutIfNeeded()

        kakaoButton.layer.cornerRadius = kakaoButton.frame.height / 2
        appleButton.layer.cornerRadius = appleButton.frame.height / 2
    }

    func labelAnimate() {
        for (index, label) in labels.enumerated() {
            Timer.scheduledTimer(withTimeInterval: TimeInterval(1*index), repeats: false) { _ in
                self.pushAnimate(label: label)
            }
        }
    }

    private func pushAnimate(label: UILabel) {
        UILabel.animate(withDuration: 0.5,
                        animations: { label.isHidden = false
            label.alpha = 1
            label.frame.origin.y -= 20
        }, completion: nil)
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? UIWindow()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        let appleIDCredential = authorization.credential
        print("AppleID Credential Authorization: \(appleIDCredential))")
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
