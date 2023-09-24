//
//  BadViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 14.09.23.
//

import Foundation
import RxSwift
import RxCocoa

protocol BadFeedbackViewModelInputs {
    var itemSelected: PublishSubject<IndexPath> { get }
    var itemDeselected: PublishSubject<IndexPath> { get }
}

protocol BadFeedbackViewModelOutputs {
    var selectedFeedback: String { get }
    var reasonText: String { get }
    
    var successSubject: PublishSubject<QuestionFeedbackResponse> { get }
    var showToastSubject: PublishSubject<String> { get }
}

protocol BadFeedbackViewModelType {
    var inputs: BadFeedbackViewModelInputs { get }
    var outputs: BadFeedbackViewModelOutputs { get }
}

final class BadFeedbackViewModel: BadFeedbackViewModelInputs, BadFeedbackViewModelOutputs {
    let feedbackList: Observable<[String]> = Observable.just([
        "질문이 너무 식상해요.",
        "질문을 이해하기 어려워요.",
        "질문 또는 아래 문구가 어색했어요.",
        "답변을 작성할 때 너무 막막했어요.",
        "질문이 나를 알아가는 데 도움이 되지 않아요.",
        "기타"
    ])

    // input
    var inputs: BadFeedbackViewModelInputs { return self }
    var itemSelected  = PublishSubject<IndexPath>()
    var itemDeselected = PublishSubject<IndexPath>()
    
    // output
    var outputs: BadFeedbackViewModelOutputs { return self }
    var selectedFeedback: String = ""
    var reasonText: String = ""
    var successSubject = PublishSubject<QuestionFeedbackResponse>()
    var showToastSubject = PublishSubject<String>()

    private let disposeBag = DisposeBag()
    
    func selectCell(index: Int) {

    }
    
    func deselectCell(index: Int) {
    }

}

extension BadFeedbackViewModel {
    func postFeedback() {
        guard let date = Date().getQuestionDate() else {
            return
        }
        let request: QuestionFeedbackRequest = QuestionFeedbackRequest(date: date, isPositive: true, question1: nil, question2: nil, question3: nil, reason: outputs.selectedFeedback, other: nil, etc: outputs.reasonText)
        QuestionFeedbackAPI.postQuestionFeedback(request: request)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.successSubject.onNext(response)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                switch error {
                case APIError.errorData(let errorData):
                    self.showToastSubject.onNext(errorData.message)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
