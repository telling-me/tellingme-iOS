//
//  FeedbackViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 11.09.23.
//

import Foundation

import RxCocoa
import RxRelay
import RxSwift

protocol FeedbackViewModelOutputs {
    var successSubject: PublishSubject<QuestionResponse> { get }
    var showToastSubject: PublishSubject<String> { get }
}

protocol FeedbackViewModelType {
    var outputs: FeedbackViewModelOutputs { get }
}


final class FeedbackViewModel: FeedbackViewModelType, FeedbackViewModelOutputs {
    private let disposeBag = DisposeBag()

    // output
    var outputs: FeedbackViewModelOutputs { return self }
    var successSubject = PublishSubject<QuestionResponse>()
    var showToastSubject = PublishSubject<String>()

    init() {
        fetchQuestion()
    }
    
    deinit { }
}

extension FeedbackViewModel {
    private func fetchQuestion() {
        guard let date = Date().getQuestionDate() else {
            return
        }

        QuestionAPI.getTodayQuestion(query: date)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.outputs.successSubject.onNext(response)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                switch error {
                case APIError.errorData(let errorData):
                    self.outputs.showToastSubject.onNext(errorData.message)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
