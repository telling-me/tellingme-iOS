//
//  ViewController.swift
//  tellingMe
//
//  Created by 마경미 on 08.03.23.
//

import UIKit
import Moya
import AuthenticationServices

@IBDesignable
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
//        for view in animationViews {
//            view.setShadow(color: UIColor(red: 0.68, green: 0.892, blue: 0.823, alpha: 0.9), radius: 20)
//        }
//        loginView.setShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.08), radius: 20)
    }

    func pushSignUp() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "signUp")as? SignUpViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    func pushHome() {
        print("push 좀 해")
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }
        
        // MainTabBar의 두 번째 탭으로 이동합니다.
        tabBarController.selectedIndex = 1
        
        // MainTabBar를 present 합니다.
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
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
            callAppleAPI()
        } else {
            callKakaoAPI()
        }
    }
}
