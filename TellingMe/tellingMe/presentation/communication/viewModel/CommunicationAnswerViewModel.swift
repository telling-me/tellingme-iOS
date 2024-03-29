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
        let question: Question
    }
    
    var answerId: Int {
        return CommunicationData.shared.communicationList[receivedData.index][receivedData.indexPath.row].answerId
    }
    var userId: String {
        return CommunicationData.shared.communicationList[receivedData.index][receivedData.indexPath.row].userId
    }
    
    var receivedData: ReceiveData = ReceiveData(index: 0, indexPath: IndexPath(row: 0, section: 0), question: Question(date: nil, question: "", phrase: ""))
    // answerviewcontroller와 좋아요 데이터를 공유하기 위한 subject
    var shareLikeSubject = PublishSubject<LikeResponse>()
    // 전 뷰컨트롤러로부터 받는 데이터 개체
    let dataSubject = PublishSubject<ReceiveData>()
    // Answr 데이터 개체
    let answerSubject = PublishSubject<GetAnswerRespose>()
    var answerData = GetAnswerRespose.emptyAnswer
    var likeResponseData = PublishSubject<LikeResponse>()
    let showToastSubject = PublishSubject<String>()
    let questionSubject = PublishSubject<Question>()
    
    let disposeBag = DisposeBag()
    
    init() {
        dataSubject
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                self.receivedData = data
                questionSubject.onNext(data.question)
            })
            .disposed(by: disposeBag)
    }

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
                CommunicationData.shared.communicationList[receivedData.index][receivedData.indexPath.row].isLiked = response.isLiked
                CommunicationData.shared.communicationList[receivedData.index][receivedData.indexPath.row].likeCount = response.likeCount
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
