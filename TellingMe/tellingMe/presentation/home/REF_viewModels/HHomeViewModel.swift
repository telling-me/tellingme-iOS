//
//  HHomeViewModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

import Moya
import RxCocoa
import RxSwift

protocol HomeViewModelInputs {
    func alarmTapped()
    func myPageTapped()
    func writingButtonTapped()
}

protocol HomeViewModelOutputs {
    var pushNotificationPermission: BehaviorRelay<PushNotificationModelType?> { get }
    var isAlarmUnread: BehaviorRelay<Bool> { get }
    var todayQuestion: BehaviorRelay<QuestionModelType> { get }
    var isQuestionAnswered: BehaviorRelay<Bool> { get }
    var answerInRow: BehaviorRelay<Int> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HHomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    
    typealias DateQuery = String
    private var disposeBag = DisposeBag()
    
    var pushNotificationPermission: BehaviorRelay<PushNotificationModelType?> = BehaviorRelay(value: nil)
    var isAlarmUnread: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var isQuestionAnswered: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var todayQuestion: BehaviorRelay<QuestionModelType> = BehaviorRelay(value: QuestionModel(date: [2023,00,00], title: "", phrase: "", isErrorOccured: false))
    var answerInRow: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
    init() {
        getMainComponentData()
        loadPushNotificationPopUpIfNeeded()
        getIsAnyAlarmUnread()
        checkAbnormalDevice()
    }
    
    func alarmTapped() {
        print("Alarm Tapped")
    }
    
    func myPageTapped() {
        print("MyPage Tapped")
    }
    
    func writingButtonTapped() {
        print("Writing Button Tapped")
    }
}
    

extension HHomeViewModel {
    
    // TODO: Custom Error 만들고 분기처리하기
    private func getMainComponentData() {
        let query: DateQuery = self.getNewDateString()
        
        QuestionAPI.getTodayQuestion(qeury: query)
            .retry(maxAttempts: 3, delay: 2)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                let data: QuestionModel = QuestionModel(date: response.date, title: response.title, phrase: response.phrase, isErrorOccured: false)
                self.todayQuestion.accept(data)
            }, onError: { [weak self] error in
                guard let self else { return }
                print("❗️ Network failed to fetch Home Question Data: \(error)")

                let data: QuestionModelWithError = QuestionModelWithError(errorMessage: "\(error)")
                self.todayQuestion.accept(data)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadPushNotificationPopUpIfNeeded() {
        UserAPI.getPushNotificationInfo()
            .retry(maxAttempts: 3, delay: 1)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                if let status = response.allowNotification,
                   let token = response.pushToken {
                    print("\(status), \(token)")
                } else {
                    let data: PushNotificationModel = PushNotificationModel(allowNotification: response.allowNotification, pushToken: response.pushToken)
                    self.pushNotificationPermission.accept(data)
                }
            }, onError: { [weak self] error in
                guard let self else { return }
                switch error {
                case APIError.errorData(let errorData):
                    let data: PushNotificationModelWithError = PushNotificationModelWithError(errorMessage: "\(errorData)")
                    self.pushNotificationPermission.accept(data)
                default:
                    let data: PushNotificationModelWithError = PushNotificationModelWithError(errorMessage: "푸시 알림 정보를 받아오는데 실패하였습니다.")
                    self.pushNotificationPermission.accept(data)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func getIsAnyAlarmUnread() {
        AlarmNotificationAPI.getAlarmSummary()
            .retry(maxAttempts: 2, delay: 1)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                self.isAlarmUnread.accept(response.status)
            })
            .disposed(by: disposeBag)
    }
    
    /// 디바이스가 iPhone SE 모델과 같은 비정상적인 비율을 가진 모델인지 확인합니다.
//    private func checkAbnormalDevice() {
//        let userDefaults = UserDefaults.standard
//        if userDefaults.bool(forKey: StringLiterals.isDeviceChecked) != false {
//            return
//        }
//        
//        let deviceName = UIDevice.current.name
//        let abnormalDeviceList = DeviceLiterals.allCases
//        
//        abnormalDeviceList.forEach { device in
//            if deviceName == device.deviceName {
//                userDefaults.set(true, forKey: StringLiterals.isDeviceAbnormal)
//                return
//            }
//        }
//        userDefaults.set(true, forKey: StringLiterals.isDeviceChecked)
//    }
}

extension HHomeViewModel {
    private func getNewDateString() -> DateQuery {
        guard let newDateString = Date().getQuestionDate() else {
            return "2023-01-01"
        }
        return newDateString
    }
}
