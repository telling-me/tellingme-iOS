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
class ViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet var labels: [UILabel]!

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

    @IBAction func clickAPITest(_ sender: Any) {
        let request = TestRequest()
        TestAPI.getTest(request: request) { response, error in
            guard let response = response else {
                print(error ?? #function)
                return
            }
            print(response)
        }
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
            let button = UIButton()
            button.setTitle("카카오로 계속하기", for: .normal)
            button.addTarget(self, action: #selector(clickKakaoLogin), for: .touchDown)
            button.backgroundColor = UIColor(red: 0.996, green: 0.898, blue: 0, alpha: 1)
            button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            button.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        let appleButton: ASAuthorizationAppleIDButton = {
            let button = ASAuthorizationAppleIDButton(type: .continue, style: .black)
            button.addTarget(self, action: #selector(clickAppleLogin), for: .touchDown)
            return button
        }()

        loginStackView.addArrangedSubview(kakaoButton)
        loginStackView.addArrangedSubview(appleButton)

        kakaoButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        kakaoButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor).isActive = true
        appleButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        appleButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor).isActive = true
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
        },
                        completion: nil)
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
