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
    var fistSliderObservable: BehaviorSubject<Float> { get set }
    var secondSliderObservable: BehaviorSubject<Float> { get set }
    var thirdSliderObservable: BehaviorSubject<Float> { get set}
}

protocol GoodFeedbackViewModelOutputs {
    var firstSliderValue: BehaviorSubject<Int> { get }
    var secondSliderValue: BehaviorSubject<Int> { get }
    var thirdSliderValue: BehaviorSubject<Int> { get }
}

protocol GoodFeedbackViewModelType {
    var inputs: GoodFeedbackViewModelInputs { get }
    var outputs: GoodFeedbackViewModelOutputs { get }
}

final class GoodFeedbackViewModel {
    private let questions: [String] = ["질문과 아래 문구가\n자연스럽게 연결되나요? *", "스스로에 대해 생각할\n수 있는 질문이었나요? *", "답변을 작성할 때\n어렵거나 막막했나요?", "그 외 하고 싶은 말을\n자유롭게 적어주세요."]
    private let disposeBag = DisposeBag()
}
