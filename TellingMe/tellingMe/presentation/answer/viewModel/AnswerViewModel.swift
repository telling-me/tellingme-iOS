//
//  AnswerViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 21.05.23.
//

import Foundation

import RxCocoa
import RxSwift

protocol AnswerViewModelInputs {
//    var clickedChangeQuestion
//    var clickedFoldView
//    var clickedBackNavigation
//    var inputTextField
//    var toggleSwitch
//    var clickedRegisterButton
}

protocol AnswerViewModelOutputs {
    var changeQuestionSubject: PublishSubject<QuestionType> { get }
    var foldViewSubject: BehaviorRelay<Bool> { get }
    var inputTextRelay: BehaviorRelay<String> { get }
    var tolggleSwitchSubject: BehaviorRelay<Void> { get }
    var countTextRelay: BehaviorRelay<String> { get }
    var toastSubject: PublishSubject<String> { get }
    var questionSubject: PublishSubject<Question> { get }
}

protocol AnswerViewModelType {
    var inputs: AnswerViewModelInputs { get }
    var outputs: AnswerViewModelOutputs { get }
}

final class AnswerViewModel: AnswerViewModelType, AnswerViewModelInputs, AnswerViewModelOutputs {

    // 옛날꺼
    var questionDate: String? = Date().getQuestionDate()
    var modalChanged: Int = 0
    let content: String = ""
    var date: String = Date().todayFormat()
    var emotion: Int? = nil
    var emotions = [Emotion(image: "Happy", text: "행복해요"), Emotion(image: "Proud", text: "뿌듯해요"), Emotion(image: "Meh", text: "그저 그래요"), Emotion(image: "Tired", text: "피곤해요"), Emotion(image: "Sad", text: "슬퍼요"), Emotion(image: "Angry", text: "화나요")]
    let plusEmotions = [
        Emotion(image: "Happy", text: "행복해요"), Emotion(image: "Proud", text: "뿌듯해요"), Emotion(image: "Meh", text: "그저 그래요"), Emotion(image: "Tired", text: "피곤해요"), Emotion(image: "Sad", text: "슬퍼요"), Emotion(image: "Angry", text: "화나요"),
        Emotion(image: "Excited", text: "설레요"), Emotion(image: "Thrilled", text: "신나요"), Emotion(image: "Relaxed", text: "편안해요"), Emotion(image: "Lethargic", text: "무기력해요"), Emotion(image: "Lonely", text: "외로워요"), Emotion(image: "Complicated", text: "복잡해요")
    ]
//    var questionDate: String? = "2023-11-29"
    var isFull: Bool = false
    
    var disposeBag = DisposeBag()
    
    // inputs
    var inputs: AnswerViewModelInputs { return self }
    
    // outputs
    var outputs: AnswerViewModelOutputs { return self }
    var changeQuestionSubject: PublishSubject<QuestionType> = PublishSubject<QuestionType>()
    var foldViewSubject: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var inputTextRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    var tolggleSwitchSubject: BehaviorRelay<Void> = BehaviorRelay(value: ())
    var countTextRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    var toastSubject: PublishSubject<String> = PublishSubject<String>()
    var questionSubject: PublishSubject<Question> = PublishSubject<Question>()
    
    init() {
        getQuestion()
    }
}

extension AnswerViewModel {
    private func getQuestion() {
        QuestionAPI.getTodayQuestion(query: "2023-11-29")
            .map { response in
                return Question(date: response.date, question: response.title, phrase: response.phrase)
            }
            .subscribe(onNext: { [weak self] question in
                guard let self else { return }
                questionSubject.onNext(question)
            }, onError: { [weak self] error in
                guard let self else { return }
                toastSubject.onNext("질문을 불러오지 못 했습니다.")
            })
            .disposed(by: disposeBag)
    }
    
    private func registerAnswer() {

    }
}
