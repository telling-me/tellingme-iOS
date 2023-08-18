//
//  CommunicationAnswerViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 07.08.23.
//

import Foundation
import RxSwift
import RxCocoa

class CommunicationAnswerViewModel {
    struct ReceiveData {
        let indexPath: IndexPath
        let question: QuestionResponse
        let answer: Content
    }
    var index = 0
    var answerId: Int = 0
    var indexPath: IndexPath = IndexPath()
    // answerviewcontroller와 좋아요 데이터를 공유하기 위한 subject
    var shareLikeSubject = PublishSubject<LikeResponse>()
    // 전 뷰컨트롤러로부터 받는 데이터 개체
    let dataSubject = BehaviorSubject<ReceiveData>(value: ReceiveData(indexPath: IndexPath(), question: QuestionResponse.standardQuestion, answer: Content.defaultContent))
    var likeResponseData = PublishSubject<LikeResponse>()
    let showToastSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()

    func postLike() {
        let request = LikeRequest(answerId: answerId)
        LikeAPI.postLike(request: request)
            .subscribe(onNext: { [weak self] response in
                self?.likeResponseData.onNext(response)
            }, onError: { [weak self] error in
                if case APIError.errorData(let errorData) = error {
                    self?.showToastSubject.onNext(errorData.message)
                } else if case APIError.tokenNotFound = error {
                    self?.showToastSubject.onNext("login으로 push할게요")
                } else {
                    self?.showToastSubject.onNext("An error occurred")
                }
            }).disposed(by: disposeBag)
    }

//    func fetchAnswerData() {
//        AnswerAPI.getAnswerWithId(query: answerId)
//            .subscribe(onNext: { [weak self] response in
//                self?.responseSubject.onNext(response)
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
}
