////
////  PushNotificationModalRepository.swift
////  tellingMe
////
////  Created by 마경미 on 12.07.23.
////
//
//import Foundation
//
//extension PushNotificationModalViewController {
//    func postNotification(_ isAgree: Bool) {
//        let request = AllowedNotificationRequest(notificationStatus: value)
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
//            })
//            .disposed(by: disposeBag)
//    }
//    //    func sendFirebaseToken() {
//    //        guard let token = KeychainManager.shared.load(key: Keys.firebaseToken.rawValue) else {
//    //            return
//    //        }
//    //        UserAPI.postFirebaseToken(request: FirebaseTokenRequest(pushToken: token)) { result in
//    //            switch result {
//    //            case .success:
//    //                break
//    //            case .failure(let error):
//    //                switch error {
//    //                case let .errorData(errorData):
//    //                    self.showToast(message: errorData.message)
//    //                case .tokenNotFound:
//    //                    print("login으로 push할게요")
//    //                default:
//    //                    print(error)
//    //                }
//    //            }
//    //        }
//    //    }
//}
