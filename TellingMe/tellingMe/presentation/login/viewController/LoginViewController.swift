//
//  ViewController.swift
//  tellingMe
//
//  Created by 마경미 on 08.03.23.
//

import UIKit
import Moya
import AuthenticationServices

class LoginViewController: UIViewController {
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet var animationViews: [UIImageView]!
    @IBOutlet weak var rotateAnimationView: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var appleButton: ASAuthorizationAppleIDButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        animation()
    }

    func setUI() {
        loginView.setTopCornerRadius()
        loginView.setShadow(shadowRadius: 20)
        for view in animationViews {
            view.setShadow2()
        }
    }

    func pushSignUp() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "signUp")as? SignUpViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    func pushHome() {
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }

        tabBarController.selectedIndex = 0
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
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
            KeychainManager.shared.save("apple", key: Keys.socialLoginType.rawValue)
            callAppleAPI()
        } else {
            KeychainManager.shared.save("kakao", key: Keys.socialLoginType.rawValue)
            callKakaoAPI()
        }
    }
}
