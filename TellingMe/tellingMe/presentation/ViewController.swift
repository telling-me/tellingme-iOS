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

@IBDesignable
class ViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var loginStackView: UIStackView!

    @objc
    func clickKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk() success.")
                    // do something
                    _ = oauthToken
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    _ = oauthToken
                    // 관련 메소드 추가
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
        setLoginButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        labelAnimate()
    }

    func setLoginButtons() {
        let kakaoButton: UIButton = {
            let button = UIButton()

            button.titleLabel?.text = "카카오 계정으로 시작하기"
            button.addTarget(self, action: #selector(clickKakaoLogin), for: .touchDown)
            button.backgroundColor = .black
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        let appleButton: ASAuthorizationAppleIDButton = {
            let button = ASAuthorizationAppleIDButton(type: .continue, style: .black)
            button.addTarget(self, action: #selector(clickAppleLogin), for: .touchDown)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        kakaoButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        appleButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        loginStackView.addArrangedSubview(kakaoButton)
        loginStackView.addArrangedSubview(appleButton)

        kakaoButton.layer.cornerRadius = kakaoButton.frame.height / 2
        appleButton.layer.cornerRadius = appleButton.frame.height / 2
    }

    func labelAnimate() {
        let now = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: now + 1) {
            self.pushAnimate(label: self.label1)
        }
        DispatchQueue.main.asyncAfter(deadline: now + 2) {
            self.pushAnimate(label: self.label2)
        }
        DispatchQueue.main.asyncAfter(deadline: now + 3) {
            self.label3.font = UIFont(name: "NanumSquareRoundOTFB", size: 26)
            self.pushAnimate(label: self.label3)
        }
    }

    private func pushAnimate(label: UILabel) {
        label.isHidden = false
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = .init(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromTop
        label.layer.add(transition, forKey: CATransitionType.push.rawValue)
    }
}

extension ViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
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
