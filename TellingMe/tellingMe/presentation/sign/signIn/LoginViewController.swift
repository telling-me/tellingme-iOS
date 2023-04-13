//
//  ViewController.swift
//  tellingMe
//
//  Created by 마경미 on 08.03.23.
//

import UIKit
import AuthenticationServices

@IBDesignable
class LoginViewController: UIViewController {
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet var animationViews: [UIImageView]!
    @IBOutlet weak var rotateAnimationView: UIImageView!
    @IBOutlet weak var loginView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        animation()
    }

    func setUI() {
        animationViews[0].setShadow(color: UIColor(red: 0.765, green: 0.967, blue: 0.866, alpha: 0.5), radius: 4)
        animationViews[1].setShadow(color: UIColor(red: 0.765, green: 0.967, blue: 0.866, alpha: 0.5), radius: 4)
        animationViews[2].setShadow(color: UIColor(red: 0.765, green: 0.967, blue: 0.866, alpha: 0.5), radius: 4)
        animationViews[3].setShadow(color: UIColor(red: 0.68, green: 0.892, blue: 0.823, alpha: 0.9), radius: 20)
        animationViews[4].setShadow(color: UIColor(red: 0.68, green: 0.892, blue: 0.823, alpha: 0.9), radius: 20)
        loginView.setShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.08), radius: 20)
    }

    func pushSignUp() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "signUp")as? SignUpViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    func animation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            let scale = CGAffineTransform(translationX: 0, y: 10)
            self.animationViews[0].transform = scale
            self.animationViews[1].transform = scale
            self.animationViews[2].transform = scale
            self.animationViews[3].transform = scale
            self.animationViews[4].transform = scale
        }

        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear]) {
            let scale = CGAffineTransform(rotationAngle: .pi / 2)
            self.rotateAnimationView.transform = scale
        }
    }

    @IBAction func clickButton(_ sender: UIButton) {
        if sender.tag == 0 {
            
        } else {
            callKakaoAPI()
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
