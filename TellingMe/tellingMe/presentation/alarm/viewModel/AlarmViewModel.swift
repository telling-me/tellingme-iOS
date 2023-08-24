//
//  AlarmViewModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import UIKit

import RxCocoa
import RxMoya
import RxSwift
import SnapKit
import Then

protocol AlarmNoticeViewModelInputs {
    func readAllNotice()
    func readNotice(idOf id: Int)
    func deleteNotice(idOf id: Int)
}

protocol AlarmNoticeViewModelOutpus {
    var alarmNotices: BehaviorSubject<[AlarmNotificationResponse]> { get }
    var isAlarmAllRead: BehaviorRelay<Bool> { get }
}

protocol AlarmNoticeViewModelType {
    var inputs: AlarmNoticeViewModelInputs { get }
    var outputs: AlarmNoticeViewModelOutpus { get }
}

final class AlarmNoticeViewModel: AlarmNoticeViewModelInputs, AlarmNoticeViewModelOutpus, AlarmNoticeViewModelType {
    
    var isAlarmAllRead: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var alarmNotices: BehaviorSubject<[AlarmNotificationResponse]> = BehaviorSubject(value: [])
    private var disposeBag = DisposeBag()
    
    var inputs: AlarmNoticeViewModelInputs {return self}
    var outputs: AlarmNoticeViewModelOutpus {return self}
    
    init() {
        AlarmNotificationAPI.getAllAlarmNotice()
            .bind(to: self.alarmNotices)
            .disposed(by: self.disposeBag)
        AlarmNotificationAPI.getAlarmSummary()
            .map { $0.status }
            .bind(to: self.isAlarmAllRead)
            .disposed(by: disposeBag)
        print("ETETET🤨")
        
    }
    
    func readAllNotice() {
        print("START FUNC")
        AlarmNotificationAPI.postAllAlarmAsRead()
            .subscribe { [unowned self] in
                print("1️⃣")
                switch $0 {
                case let .success(response):
                    print(response.statusCode)
                    print("2️⃣")
                    AlarmNotificationAPI.getAllAlarmNotice()
                        .bind(to: self.alarmNotices)
                        .disposed(by: self.disposeBag)
                case let .failure(error):
                    print("aaaa")
                    print("3️⃣")
                }
                print("4️⃣")
            }
            .disposed(by: disposeBag)
        print("END FUNC")
    }
    
    func readNotice(idOf id: Int) {
        AlarmNotificationAPI.postSingleAlarmAsRead(selectedId: id)
            .subscribe {
                switch $0 {
                case let .success(response):
                    print(response.statusCode)
                case let .failure(error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func deleteNotice(idOf id: Int) {
        AlarmNotificationAPI.deleteSingleAlarm(selectedId: id)
            .subscribe { [unowned self] in
                switch $0 {
                case let .success(response):
                    print(response.statusCode)
                    
                    AlarmNotificationAPI.getAllAlarmNotice()
                        .bind(to: self.alarmNotices)
                        .disposed(by: self.disposeBag)
                case let .failure(error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}

