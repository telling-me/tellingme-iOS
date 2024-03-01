//
//  HomeViewModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import UIKit

import Firebase
import Moya
import RxCocoa
import RxSwift

// MARK: - Protocols

protocol HomeViewModelInputs {
    func alarmTapped()
    func myPageTapped()
    func writingButtonTapped()
    func refreshQuestion()
    func refreshNewIncomingAlarms()
    func refreshIsAnsweredToday()
    func refreshAnswerInRow()
    func permitPushNotification()
    func declinePushNotification()
    func checkPlusUser()
    func recheckPushNotificationPermission()
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

// MARK: - ViewModel

final class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType {
    
    private var disposeBag = DisposeBag()
    
    var pushNotificationPermission: BehaviorRelay<PushNotificationModelType?> = BehaviorRelay(value: PushNotificationModel())
    var isAlarmUnread: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var isQuestionAnswered: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var todayQuestion: BehaviorRelay<QuestionModelType> = BehaviorRelay(value: (QuestionModel(date: [2023,00,00], title: "", phrase: "", isErrorOccured: false)))
    var answerInRow: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
    init() {
        getMainComponentData()
        getIsAnyAlarmUnread()
        getIsAnswered()
        getAnswerInRowInformation()
        checkAbnormalDevice()
        // When PushToken KeyChain isn't saved.
        if isPushTokenSavedInKeyChain() == false {
            loadPushNotificationPopUpIfNeeded()
        }
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
    
    func refreshQuestion() {
        getMainComponentData()
    }
    
    func refreshNewIncomingAlarms() {
        getIsAnyAlarmUnread()
    }
    
    func refreshIsAnsweredToday() {
        getIsAnswered()
    }
    
    func refreshAnswerInRow() {
        getAnswerInRowInformation()
    }
    
    func permitPushNotification() {
        postPushNotificationWith(status: true)
    }
    
    func declinePushNotification() {
        postPushNotificationWith(status: false)
    }
    
    func recheckPushNotificationPermission() {
        if isPushTokenSavedInKeyChain() == false {
            loadPushNotificationPopUpIfNeeded()
        }
    }
    
    // TODO: 인앱 결제 정보 받기
    func checkPlusUser() {
        let userDefaults = UserDefaults.standard
        let paidUserNumber: String? = userDefaults.string(forKey: StringLiterals.paidProductId)
        // 구매를 확인하는 기능이 들어갈 곳
    }
}

extension HomeViewModel {
    
    // TODO: Custom Error 만들고 분기처리하기
    private func getMainComponentData() {
        print("📌 Function: ", #function, "called in: ", #fileID)

        let query: String = self.getNewDateString()
        
        QuestionAPI.getTodayQuestion(query: query)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                let data: QuestionModel = QuestionModel(date: response.date, title: response.title, phrase: response.phrase, isErrorOccured: false)
                self.todayQuestion.accept(data)
            }, onError: { [weak self] error in
                guard let self else { return }
                print("❗️ Network failed to fetch Home Question Data: \(error)")
                let data: QuestionModelWithError = QuestionModelWithError(isErrorOccured: true, errorMessage: "\(error)")
                self.todayQuestion.accept(data)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadPushNotificationPopUpIfNeeded() {
        UserAPI.getPushNotificationInfo()
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                let notificationStatus = response.allowNotification
                let pushToken = response.pushToken
                                
                if notificationStatus == nil || pushToken == nil {
                    let data = PushNotificationModelWithError(allowNotification: notificationStatus, pushToken: pushToken, errorMessage: "Push Notification Status Needs to be decided")
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
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                self.isAlarmUnread.accept(response.status)
            })
            .disposed(by: disposeBag)
    }
    
    private func getIsAnswered() {
        let query: String = getNewDateString()
        
        AnswerAPI.getAnswerWithDate(query: query)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                self.isQuestionAnswered.accept(true)
            }, onError: { [weak self] response in
                guard let self else { return }
                self.isQuestionAnswered.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    private func getAnswerInRowInformation() {
        let query: String = getNewDateString()
        
        AnswerAPI.getAnswerRecord(query: query)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                self.answerInRow.accept(response.count)
            })
            .disposed(by: disposeBag)
    }
    
    /// 디바이스가 iPhone SE 모델과 같은 비정상적인 비율을 가진 모델인지 확인합니다.
    private func checkAbnormalDevice() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: StringLiterals.isDeviceChecked) != false {
            return
        }

        let deviceName = UIDevice.current.name
        let abnormalDeviceList = DeviceLiterals.allCases

        abnormalDeviceList.forEach { device in
            if deviceName == device.deviceName {
                userDefaults.set(true, forKey: StringLiterals.isDeviceAbnormal)
                return
            }
        }
        userDefaults.set(true, forKey: StringLiterals.isDeviceChecked)
    }
    
    private func postPushNotificationWith(status: Bool) {
        presentNotificationAuthorization()
        guard let token = Messaging.messaging().fcmToken else {
            print("Fetching Push Token Failed")
            return
        }
            
        UserAPI.postPushNotificationInfo(request: PushNotificationInfoRequest(allowNotification: status, pushToken: token))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                KeychainManager.shared.save(token, key: Keys.firebaseToken.rawValue)
                self.pushNotificationPermission.accept(PushNotificationModel(allowNotification: response.allowNotification, pushToken: response.pushToken, errorMessage: nil))
            }, onError: { error in
                print("Posting Push Notification Failed with an error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewModel {
    
    private func presentNotificationAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { (granted, error) in
                if granted {}
                if let error = error {
                    print(error)
                }
            }
    }
    
    private func isPushTokenSavedInKeyChain() -> Bool {
        if KeychainManager.shared.load(key: Keys.firebaseToken.rawValue) != nil {
            return true
        } else {
            return false
        }
    }
    
    private func getNewDateString() -> String {
        guard let newDateString = Date().getQuestionDate() else {
            return "2023-01-01"
        }
        return newDateString
    }
}
