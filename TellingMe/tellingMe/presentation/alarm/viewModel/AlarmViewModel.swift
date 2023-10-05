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

protocol AlarmNoticeViewModelInputs {
    func readAllNotice()
    func readNotice(idOf id: Int)
    func deleteNotice(idOf id: Int)
    func openSafariWithUrl(url: String?)
    func initializeAnswerData(answerId: Int, publishedDate: String)
    func editNoticeData(with data: [AlarmNotificationResponse])
    func refetchNoticeData()
}

protocol AlarmNoticeViewModelOutpus {
    var alarmNotices: BehaviorSubject<[AlarmNotificationResponse]> { get }
    var isAlarmAllRead: BehaviorRelay<Bool> { get }
    var answerData: BehaviorSubject<DetailAnswerForEachNotceModel> { get }
}

protocol AlarmNoticeViewModelType {
    var inputs: AlarmNoticeViewModelInputs { get }
    var outputs: AlarmNoticeViewModelOutpus { get }
}

final class AlarmNoticeViewModel: AlarmNoticeViewModelInputs, AlarmNoticeViewModelOutpus, AlarmNoticeViewModelType {

    /// Needs to modified
    var answerData: BehaviorSubject<DetailAnswerForEachNotceModel> = BehaviorSubject(value: DetailAnswerForEachNotceModel.defaultValue)
    var isAlarmAllRead: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var alarmNotices: BehaviorSubject<[AlarmNotificationResponse]> = BehaviorSubject(value: [])
    private var disposeBag = DisposeBag()
    
    var inputs: AlarmNoticeViewModelInputs {return self}
    var outputs: AlarmNoticeViewModelOutpus {return self}
    
    init() {
        fetchNoticeData()
        fetchIsNoticeAllRead()
    }
    
    init(answerId: Int, datePublished: String) {
        initializeAnswerData(answerId: answerId, publishedDate: datePublished)
    }
    
    /// 1️⃣ Cell 의 answerId 를 가져온다.
    /// 2️⃣ emotion, like, content 를 가져온다.
    func initializeAnswerData(answerId: Int, publishedDate: String) {
        Observable.zip(AnswerAPI.getAnswerWithId(query: answerId), AlarmNotificationAPI.getQuestionForNotice(publishedDate: publishedDate))
            .subscribe(onNext: { [weak self] responseWithContent, responseWithQuestion in
                let dateJoined = responseWithQuestion.date.intArraytoDate3()
                let newData = DetailAnswerForEachNotceModel(withContent: .init(contentText: responseWithContent.content, likeCount: responseWithContent.likeCount), withQuestion: .init(emotion: responseWithContent.emotion, question: responseWithQuestion.title, subQuestion: responseWithQuestion.phrase, publshedDate: dateJoined))
                self?.answerData.onNext(newData)
            }, onError: { error in
                if case APIError.errorData(let errorData) = error {
                    print(errorData)
                } else if case APIError.tokenNotFound = error {
                }
            }).disposed(by: disposeBag)
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
    }
    
    func openSafariWithUrl(url: String?) {
        if let urlString = url {
            guard let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Wrong Url.")
        }
    }
    
    func editNoticeData(with data: [AlarmNotificationResponse]) {
        alarmNotices.onNext(data)
    }
    
    func refetchNoticeData() {
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
                self?.isAlarmAllRead.accept(!response.status)
            }, onError: { error in
                if case APIError.errorData(_) = error {
                } else if case APIError.tokenNotFound = error {
                }
            })
            .disposed(by: disposeBag)
    }
}

