//
//  BadViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 14.09.23.
//

import Foundation

import RxCocoa
import RxSwift

protocol BadFeedbackViewModelInputs {
    var itemSelected: PublishSubject<IndexPath> { get }
    var itemDeselected: PublishSubject<IndexPath> { get }
    var textObservable: BehaviorRelay<String?> { get }
}

protocol BadFeedbackViewModelOutputs {
    var selectedFeedback: BehaviorRelay<[Int]> { get }
    var reasonText: String? { get }
    
    var alertSubject: PublishSubject<String> { get }
    var successSubject: PublishSubject<Void> { get }
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
    private let disposeBag = DisposeBag()

    // input
    var inputs: BadFeedbackViewModelInputs { return self }
    var itemSelected = PublishSubject<IndexPath>()
    var itemDeselected = PublishSubject<IndexPath>()
    var textObservable = BehaviorRelay<String?>(value: nil)
    
    // output
    var outputs: BadFeedbackViewModelOutputs { return self }
    var selectedFeedback = BehaviorRelay<[Int]>(value: [])
    var reasonText: String? = nil
    var alertSubject = PublishSubject<String>()
    var successSubject = PublishSubject<Void>()
    var showToastSubject = PublishSubject<String>()
    
    init() {
        textObservable.bind(onNext: { [weak self] text in
            guard let self = self else { return }
            self.reasonText = text
        })
        .disposed(by: disposeBag)
    }
    
    deinit {
        print("BadFeedbackViewModel Deinit")
    }
}

extension BadFeedbackViewModel {
    func selectItem(indexPath: IndexPath) {
        var array = selectedFeedback.value
        array.append(indexPath.row)
        selectedFeedback.accept(array)
    }
    
    func deselectItem(indexPath: IndexPath) {
        var array = selectedFeedback.value
        array.removeAll(where: { $0 == indexPath.row })
        selectedFeedback.accept(array)
    }
}

extension BadFeedbackViewModel {
    func postFeedback() {
        guard let date = Date().getQuestionDate() else {
            self.outputs.showToastSubject.onNext("날짜를 불러올 수 없습니다.")
            return
        }
        
        guard outputs.reasonText?.count ?? 0 <= 500 else {
            self.outputs.showToastSubject.onNext("하고싶은 말은 500자 이내로 작성해주세요.")
            return
        }

        guard !outputs.selectedFeedback.value.isEmpty else {
            self.outputs.alertSubject.onNext("필수 항목을 완료해주세요.")
            return
        }

        let reason = outputs.selectedFeedback.value.sorted().intArraytoString()
        let request: QuestionFeedbackRequest = QuestionFeedbackRequest(date: date, isPositive: true, question1: nil, question2: nil, question3: nil, reason: reason, other: nil, etc: outputs.reasonText)

        QuestionFeedbackAPI.postQuestionFeedback(request: request)
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
