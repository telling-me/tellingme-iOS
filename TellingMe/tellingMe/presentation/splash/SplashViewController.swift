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
        resetBackgroundStayedTime()
        
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
    private func resetBackgroundStayedTime() {
        UserDefaults.standard.set(0, forKey: StringLiterals.backgroundStayingTime)
    }
    
    private func callKeychain() {
        KeychainManager.shared.delete(key: Keys.isLockedWithPassword.keyString)
        KeychainManager.shared.delete(key: Keys.isLockedWithBiometry.keyString)
        KeychainManager.shared.delete(key: Keys.passwordKey.keyString)
    }
}
