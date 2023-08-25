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
        fetchNoticeData()
        fetchIsNoticeAllRead()
    }
    
    func readAllNotice() {
        AlarmNotificationAPI.postAllAlarmAsRead()
            .subscribe(onNext: { _ in
                print("Alarms are all read.")
            }, onError: { error in
                if case APIError.errorData(_) = error {
                } else if case APIError.tokenNotFound = error {
                }
            })
            .disposed(by: disposeBag)
        
        fetchNoticeData()
    }
    
    func readNotice(idOf id: Int) {
        AlarmNotificationAPI.postSingleAlarmAsRead(selectedId: id)
            .subscribe(onNext: { _ in
                print("✅ Notice Id: \(id) has been read.")
            }, onError: { error in
                if case APIError.errorData(_) = error {
                } else if case APIError.tokenNotFound = error {
                }
            })
            .disposed(by: disposeBag)
    }
    
    func deleteNotice(idOf id: Int) {
        AlarmNotificationAPI.deleteSingleAlarm(selectedId: id)
            .subscribe(onNext: { _ in
                print("🗑️ Notice Id: \(id) has been removed.")
            }, onError: { error in
                if case APIError.errorData(_) = error {
                } else if case APIError.tokenNotFound = error {
                }
            })
            .disposed(by: disposeBag)
        
        fetchNoticeData()
    }
}

extension AlarmNoticeViewModel {
    private func fetchNoticeData() {
        AlarmNotificationAPI.getAllAlarmNotice()
            .subscribe(onNext: { [weak self] response in
                self?.alarmNotices.onNext(response)
            }, onError: { error in
                if case APIError.errorData(_) = error {
                } else if case APIError.tokenNotFound = error {
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchIsNoticeAllRead() {
        AlarmNotificationAPI.getAlarmSummary()
            .subscribe(onNext: { [weak self] response in
                self?.isAlarmAllRead.accept(response.status)
            }, onError: { error in
                if case APIError.errorData(_) = error {
                } else if case APIError.tokenNotFound = error {
                }
            })
            .disposed(by: disposeBag)
    }
}

