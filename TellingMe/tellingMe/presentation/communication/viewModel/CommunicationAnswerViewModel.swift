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
        // 3일치 질문 중 index
        let index: Int
        let indexPath: IndexPath
        let question: QuestionResponse

        static var defaultData: ReceiveData {
            return ReceiveData(index: 0, indexPath: IndexPath(row: 0, section: 0), question: QuestionResponse.standardQuestion)
        }
    }
    var index: Int = 0
    var answerId: Int {
        return CommunicationData.shared.communicationList[index][indexPath.row].answerId
    }
    var indexPath: IndexPath = IndexPath()
    // answerviewcontroller와 좋아요 데이터를 공유하기 위한 subject
    var shareLikeSubject = PublishSubject<LikeResponse>()
    // 전 뷰컨트롤러로부터 받는 데이터 개체
    let dataSubject = BehaviorSubject<ReceiveData>(value: ReceiveData.defaultData)
    // Answr 데이터 개체
    let answerSubject = PublishSubject<GetAnswerRespose>()
    var answerData = GetAnswerRespose.emptyAnswer
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

    func fetchAnswerData() {
        AnswerAPI.getAnswerWithId(query: answerId)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.answerSubject.onNext(response)
                self.answerData = response
                CommunicationData.shared.communicationList[index][indexPath.row].isLiked = response.isLiked
                CommunicationData.shared.communicationList[index][indexPath.row].likeCount = response.likeCount
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
}
