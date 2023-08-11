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
        let animationView: LottieAnimationView = .init(name: "Splash")
        splashView.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.leadingAnchor.constraint(equalTo: splashView.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: splashView.trailingAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: splashView.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: splashView.bottomAnchor).isActive = true

        let loginObservable = Observable.create { observer in
            let isLogined = self.performAutoLogin()
            observer.onNext(isLogined)
            observer.onCompleted()
            return Disposables.create()
        }

        animationView.play { _ in
             self.performAutoLoginAndNavigate()
         }
    }
}
