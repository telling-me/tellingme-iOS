//
//  SettingViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SettingViewModel {
    struct SettingView {
        let id: String
        let view: UIViewController
    }

    var pushToggleValue: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let items = [SettingView(id: "myInfo", view: MyInfoViewController()), SettingView(id: "privacyPolicy", view: UIViewController()), SettingView(id: "privacyPolicy", view: UIViewController()), SettingView(id: "withdrawal", view: WithdrawalViewController())]
    var itemsCount: Int?

    let showToastSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()

    init() {
        itemsCount = items.count
    }

    func fetchNotificationData() {
        UserAPI.getisAllowedNotification()
            .subscribe(onNext: { [weak self] response in
                self?.pushToggleValue.accept(response.allowNotification)
            }, onError: { [weak self] error in
                if case APIError.errorData(let errorData) = error {
                    self?.showToastSubject.onNext(errorData.message)
                } else if case APIError.tokenNotFound = error {
                    self?.showToastSubject.onNext("login으로 push할게요")
                } else {
                    self?.showToastSubject.onNext("An error occurred")
                }
            })
            .disposed(by: disposeBag)
    }

    // 푸시알림
    func postNotification(_ value: Bool) {
        let request = AllowedNotificationRequest(notificationStatus: value)
        UserAPI.postNotification(request: request)
            .subscribe(onNext: { [weak self] _ in
            }, onError: { [weak self] error in
                if case APIError.errorData(let errorData) = error {
                    self?.showToastSubject.onNext(errorData.message)
                } else if case APIError.tokenNotFound = error {
                    self?.showToastSubject.onNext("login으로 push할게요")
                } else {
                    self?.showToastSubject.onNext("An error occurred")
                }
                self?.pushToggleValue.accept(!value)
            })
            .disposed(by: disposeBag)
    }
}
