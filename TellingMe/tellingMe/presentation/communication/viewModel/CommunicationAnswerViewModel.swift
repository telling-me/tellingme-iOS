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
        let answerId: Int
        let question: QuestionResponse
    }
    var answerId: Int = 0
    let answerIdSubject = BehaviorSubject<ReceiveData>(value: ReceiveData(answerId: 0, question: QuestionResponse.standardQuestion))
    let questionData: String = ""
    let contentData: String = ""
    let isLike = BehaviorRelay<Bool>(value: false)
    var responseSubject = PublishSubject<GetAnswerRespose>()
    
    let showToastSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()

    func toggleisLike() {
        let request = LikeRequest(answerId: answerId)
        LikeAPI.postLike(request: request) { result in
            switch result {
            case .success(let resposne):
                self.isLike.accept(!self.isLike.value)
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchAnswerData() {
        AnswerAPI.getAnswerWithId(query: answerId)
            .subscribe(onNext: { [weak self] response in
                self?.responseSubject.onNext(response)
            }, onError: { [weak self] error in
                if case APIError.errorData(let errorData) = error {
                    self?.showToastSubject.onNext(errorData.message)
                } else if case APIError.tokenNotFound = error {
                    self?.showToastSubject.onNext("login으로 push할게요")
                } else {
                    self?.showToastSubject.onNext("An error occurred")
                }
            })
            .disposed(by: disposeBag)
    }
}
