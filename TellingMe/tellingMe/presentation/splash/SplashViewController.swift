//
//  SplashViewController.swift
//  tellingMe
//
//  Created by 마경미 on 14.06.23.
//

import UIKit
import Lottie
import RxSwift

class SplashViewController: UIViewController {
    @IBOutlet weak var splashView: UIView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callKeychain()
        
        let animationView: LottieAnimationView = LottieAnimationView(name: "Splash", configuration: LottieConfiguration(renderingEngine: .mainThread))
        splashView.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.leadingAnchor.constraint(equalTo: splashView.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: splashView.trailingAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: splashView.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: splashView.bottomAnchor).isActive = true

        animationView.play { _ in
             self.performAutoLoginAndNavigate()
         }
    }
}

extension SplashViewController {
    func callKeychain() {
//        print("With Password?: 🚩", KeychainManager.shared.load(of: Keys.isLockedWithPassword.keyString))
//        print("With FaceId?: 🚩", KeychainManager.shared.load(of: Keys.isLockedWithBiometry.keyString))
//        print("Password? 🚩", KeychainManager.shared.load(key: Keys.passwordKey.keyString))
//        KeychainManager.shared.delete(key: Keys.isLockedWithPassword.keyString)
//        KeychainManager.shared.delete(key: Keys.isLockedWithBiometry.keyString)
//        KeychainManager.shared.delete(key: Keys.passwordKey.keyString)
    }
}
