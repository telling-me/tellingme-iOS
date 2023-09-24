//
//  GoodFeedbackViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 12.09.23.
//

import Foundation
import RxSwift
import RxCocoa

protocol GoodFeedbackViewModelInputs {
    var sliderObservables: [BehaviorRelay<Float>] { get set }
    var textObservables: BehaviorRelay<String?> { get }
}

protocol GoodFeedbackViewModelOutputs {
    var sliderValues: [Int] { get set }
    var reasonText: String? { get }
    var successSubject: PublishSubject<QuestionFeedbackResponse> { get }
    var showToastSubject: PublishSubject<String> { get }
}

protocol GoodFeedbackViewModelType {
    var inputs: GoodFeedbackViewModelInputs { get }
    var outputs: GoodFeedbackViewModelOutputs { get }
}

final class GoodFeedbackViewModel: GoodFeedbackViewModelType, GoodFeedbackViewModelInputs, GoodFeedbackViewModelOutputs {
    let questions: [String] = ["질문과 아래 문구가\n자연스럽게 연결되나요? *", "스스로에 대해 생각할\n수 있는 질문이었나요? *", "답변을 작성할 때\n어렵거나 막막했나요? *"]
    
    // input
    var inputs: GoodFeedbackViewModelInputs { return self }
    var sliderObservables: [BehaviorRelay<Float>] = [BehaviorRelay(value: 3.0), BehaviorRelay(value: 3.0), BehaviorRelay(value: 3.0)]
    var textObservables: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // output
    var outputs: GoodFeedbackViewModelOutputs { return self }
    var sliderValues: [Int] = [3, 3, 3]
    var reasonText: String? = nil
    let successSubject = PublishSubject<QuestionFeedbackResponse>()
    let showToastSubject = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        for (index, observable) in sliderObservables.enumerated() {
            observable.bind(onNext: { [weak self] value in
                self?.sliderValues[index] = Int(value)
            })
            .disposed(by: disposeBag)
        }
        
        textObservables.bind(onNext: { [weak self] text in
            guard let self = self else { return }
            self.reasonText = text
        })
        .disposed(by: disposeBag)
    }
}

extension GoodFeedbackViewModel {
    func postFeedback() {
        guard let date = Date().getQuestionDate() else {
            return
        }
        let request: QuestionFeedbackRequest = QuestionFeedbackRequest(date: date, isPositive: true, question1: outputs.sliderValues[0], question2: outputs.sliderValues[1], question3: outputs.sliderValues[2], reason: nil, other: nil, etc: outputs.reasonText)
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
