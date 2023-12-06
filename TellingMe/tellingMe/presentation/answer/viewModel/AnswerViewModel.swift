//
//  AnswerViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 21.05.23.
//

import Foundation

import RxCocoa
import RxSwift
import Moya

protocol AnswerViewModelInputs {
    var toggleSwitch: BehaviorRelay<Bool> { get }
    var completeButtonTapped: PublishSubject<Void> { get }
    var registerButtonTapped: PublishSubject<Void> { get }
    var inputText: BehaviorRelay<String> { get }
    func selectEmotion(indexPath: IndexPath)
}

protocol AnswerViewModelOutputs {
    var changeQuestionSubject: PublishSubject<QuestionType> { get }
    var inputTextRelay: BehaviorRelay<String> { get }
    var countTextRelay: BehaviorRelay<String> { get }
    var toastSubject: PublishSubject<String> { get }
    var questionSubject: PublishSubject<Question> { get }
    var selectedEmotionIndexSubject: BehaviorRelay<IndexPath> { get }
    var showEmotionSubject: PublishSubject<Void> { get }
    var successRegisterSubject: PublishSubject<Void> { get }
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

    var isFull: Bool = false
    var emotionList: [Emotions] = Emotions.standardEmotionArray()
    
    var disposeBag = DisposeBag()
    
    // inputs
    var inputs: AnswerViewModelInputs { return self }
    var toggleSwitch = BehaviorRelay<Bool>(value: true)
    var completeButtonTapped = PublishSubject<Void>()
    var registerButtonTapped = PublishSubject<Void>()
    var inputText = BehaviorRelay<String>(value: "")
    
    func selectEmotion(indexPath: IndexPath) {
        selectedEmotionIndexSubject.accept(indexPath)
    }
    
    // outputs
    var outputs: AnswerViewModelOutputs { return self }
    var changeQuestionSubject: PublishSubject<QuestionType> = PublishSubject<QuestionType>()
    var inputTextRelay = BehaviorRelay(value: "")
    var countTextRelay = BehaviorRelay(value: "0")
    var toastSubject = PublishSubject<String>()
    var questionSubject = PublishSubject<Question>()
    var selectedEmotionIndexSubject = BehaviorRelay<IndexPath>(value: IndexPath(row: 1, section: 0))
    var showEmotionSubject = PublishSubject<Void>()
    var successRegisterSubject = PublishSubject<Void>()
    
    init() {
        getQuestion()
        completeButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.tapRegisterButton()
            })
            .disposed(by: disposeBag)
        registerButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.registerAnswer()
            })
            .disposed(by: disposeBag)
        inputText
            .map { text -> String in
                if text.count >= 300 {
                    self.toastSubject.onNext("300자까지만 작성 가능합니다.")
                    let truncatedText = String(text.prefix(300))
                    return truncatedText
                }
                return text
            }
            .subscribe(onNext: { [weak self] text in
                guard let self else { return }
                self.outputs.countTextRelay.accept(String(text.count))
                self.outputs.inputTextRelay.accept(text)
            })
            .disposed(by: disposeBag)
    }
}

extension AnswerViewModel {
    private func tapRegisterButton() {
        if inputText.value.count < 4 {
            toastSubject.onNext("4글자 이상 입력하여 주세요.")
        } else {
            showEmotionSubject.onNext(())
        }
    }
    
    private func getQuestion() {
        guard let date = questionDate else {
            self.toastSubject.onNext("날짜에 맞는 질문을 찾을 수 없습니다.")
            return
        }
        
        QuestionAPI.getTodayQuestion(query: date)
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
        guard let date = questionDate else {
            self.toastSubject.onNext("날짜에 맞는 질문을 찾을 수 없습니다.")
            return
        }
        
        let request = RegisterAnswerRequest(content: inputText.value, date: date, emotion: selectedEmotionIndexSubject.value.row + 1, isPublic: toggleSwitch.value, isSpare: false)
        AnswerAPI.registerAnswer(request: request)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.successRegisterSubject.onNext(())
            }, onError: { [weak self] error in
                guard let self else { return }
                switch error {
                case APIError.errorData(let errorData):
                    self.toastSubject.onNext(errorData.message)
                default:
                    self.toastSubject.onNext("알 수 없는 오류가 발생했습니다.")
                }
            })
            .disposed(by: disposeBag)
    }
}
