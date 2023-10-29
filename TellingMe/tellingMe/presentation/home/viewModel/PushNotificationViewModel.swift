//
//  PushNotificationViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 11.08.23.
//

import Foundation
import RxSwift
import RxCocoa

class PushNotifiactionViewModel {
    let successSujbect = BehaviorSubject<PushNotificationInfoResponse>(value: .init(allowNotification: nil, pushToken: nil))
    let showToastSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()

//    func postNotifiactionStatus(_ isAgree: Bool) {
//        let request = AllowedNotificationRequest(notificationStatus: isAgree)
//        UserAPI.postNotification(request: request)
//            .subscribe(onNext: { [weak self] _ in
//            }, onError: { [weak self] error in
//                if case APIError.errorData(let errorData) = error {
//                    self?.showToastSubject.onNext(errorData.message)
//                } else if case APIError.tokenNotFound = error {
//                    self?.showToastSubject.onNext("login으로 push할게요")
//                } else {
//                    self?.showToastSubject.onNext("An error occurred")
//                }
//            }).disposed(by: disposeBag)
//    }
//
//    func postFirebaseToken(token: String) {
//        KeychainManager.shared.save(token, key: Keys.firebaseToken.rawValue)
//        guard let token = KeychainManager.shared.load(key: Keys.firebaseToken.rawValue) else {
//            return
//        }
//        let request = FirebaseTokenRequest(pushToken: token)
//        UserAPI.postFirebaseToken(request: request)
//            .subscribe(onNext: { _ in
//            }, onError: { [weak self] error in
//                if case APIError.tokenNotFound = error {
//                    print("should move to login")
//                } else {
//                    print(error)
//                }
//            }).disposed(by: disposeBag)
//    }
    
    func postPushNotification(isAgree: Bool, token: String) {
        KeychainManager.shared.save(token, key: Keys.firebaseToken.rawValue)
        let request = PushNotificationInfoRequest(allowNotification: isAgree, pushToken: token)
        UserAPI.postPushNotificationInfo(request: request)
            .subscribe(onNext: { [weak self] response in
                self?.successSujbect.onNext(response)
            }, onError: { [weak self] error in
                switch error {
                case APIError.errorData(let errorData):
                    self?.showToastSubject.onNext(errorData.message)
                default:
                    self?.showToastSubject.onNext("푸시 알림을 등록할 수 없습니다.")
                }
            }).disposed(by: disposeBag)
    }
}
