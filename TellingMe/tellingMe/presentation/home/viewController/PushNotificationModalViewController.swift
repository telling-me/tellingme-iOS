//
//  PushNotificationModalViewController.swift
//  tellingMe
//
//  Created by 마경미 on 12.07.23.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class PushNotificationModalViewController: UIViewController {
    let viewModel = PushNotifiactionViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var okButton: SecondaryTextButton!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.view.backgroundColor = .clear
    }

    func registerForNotification() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { (granted, error) in
                if granted {
                }

                if let error = error {
                    DispatchQueue.main.async {
                        self.showToast(message: "푸시 알림을 등록할 수 없습니다.")
                    }
                }
            }
    }

    func bindViewModel() {
        okButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.clickButton(true)
            }).disposed(by: disposeBag)
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.clickButton(false)
            }).disposed(by: disposeBag)
    }

    func clickButton(_ agree: Bool) {
        registerForNotification()
        if let token = Messaging.messaging().fcmToken {
            self.viewModel.postFirebaseToken(token: token)
        }
        self.viewModel.postNotifiactionStatus(agree)
        self.dismiss(animated: true)
    }
}
