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
    var itemSelected: PublishSubject<Int> { get }
    var itemDeselected: PublishSubject<Int> { get }
}

protocol BadFeedbackViewModelOutputs {
    var selectedFeedback: BehaviorRelay<[Int]> { get }
    var etcText: String { get }
}

protocol BadFeedbackViewModelType {
    var inputs: BadFeedbackViewModelInputs { get }
    var outputs: BadFeedbackViewModelOutputs { get }
}

final class BadFeedbackViewModel: BadFeedbackViewModelInputs, BadFeedbackViewModelOutputs {
    // input
    var itemSelected: PublishSubject<Int> = PublishSubject<Int>()
    var itemDeselected: PublishSubject<Int> = PublishSubject<Int>()
    
    // output
    var selectedFeedback: RxRelay.BehaviorRelay<[Int]> = BehaviorRelay(value: [])
    var etcText: String = ""
    
    let feedbackList: Observable<[String]> = Observable.just([
        "질문이 너무 식상해요.",
        "질문을 이해하기 어려워요.",
        "질문 또는 아래 문구가 어색했어요.",
        "답변을 작성할 때 너무 막막했어요.",
        "질문이 나를 알아가는 데 도움이 되지 않아요.",
        "기타"
    ])

    private let disposeBag = DisposeBag()
    var inputs: BadFeedbackViewModelInputs { return self }
    var outputs: BadFeedbackViewModelOutputs { return self }
    
    func selectCell(index: Int) {

    }
    
    func deselectCell(index: Int) {
    }
    
    func postFeedback() {
        
    }
}
