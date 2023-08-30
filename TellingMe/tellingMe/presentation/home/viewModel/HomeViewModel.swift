//
//  HomeViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation

import Moya
import RxCocoa
import RxSwift

class HomeViewModel {
    let today = Date().todayFormat()
    let questionDate = Date().getQuestionDate()
    var isAnswerCompleted = false
    
    let pushNotificationInfoSubject = BehaviorSubject<PushNotificationInfoResponse?>(value: nil)
    let showToastSubject = BehaviorSubject<String>(value: "")
    let disposeBag = DisposeBag()
    
    func getNewNotices(completion: @escaping (Bool) -> Void) {
        AlarmNotificationAPI.getAlarmSummary { response in
            switch response {
            case .success(let result):
                guard let newNoticeExist = result?.status else {return}
                completion(newNoticeExist)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    init() {
        getPushNotificationInfo()
    }
    
    // MARK: 이미 데이터베이스에 정보를 못 넣은 사람들을 위한 메서드로 nil일 경우에 onNext
    func getPushNotificationInfo() {
        UserAPI.getPushNotificationInfo()
            .subscribe(onNext: { [weak self] response in
                if let status = response.allowNotification,
                   let token = response.pushToken {
                    print("\(status), \(token)")
                } else {
                    self?.pushNotificationInfoSubject.onNext(response)
                }
            }, onError: { [weak self] error in
                switch error {
                case APIError.errorData(let errorData):
                    self?.showToastSubject.onNext(errorData.message)
                default:
                    self?.showToastSubject.onNext("푸시 알림 정보를 받아오는데 실패하였습니다.")
                }
            }).disposed(by: disposeBag)
    }
}
