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
    var clickedChangeQuestion
    var clickedFoldView
    var clickedBackNavigation
    var inputTextField
    var toggleSwitch
    var clickedRegisterButton
}

protocol AnswerViewModelOutputs {
    var changeQuestionSubject: PublishSubject<QuestionType> { get }
    var foldViewSubject: PublishSubject<Bool> { get }
    var inputTextRelay: BehaviorRelay<String> { get }
    var tolggleSwitchSubject: BehaviorRelay<Void> { get }
    var countTextRelay: BehaviorRelay<String> { get }
    var toastSubject: PublishSubject<String> { get }
}

protocol AnswerViewModelType {
    var inputs: AnswerViewModelInputs { get }
    var outputs: AnswerViewModelOutputs { get }
}

final class AnswerViewModel: AnswerViewModelType, AnswerViewModelInputs, AnswerViewModelOutputs {

    // 옛날꺼
    var modalChanged: Int = 0
    let content: String = ""
    var date: String = Date().todayFormat()
    var emotion: Int? = nil
    var emotions = [Emotion(image: "Happy", text: "행복해요"), Emotion(image: "Proud", text: "뿌듯해요"), Emotion(image: "Meh", text: "그저 그래요"), Emotion(image: "Tired", text: "피곤해요"), Emotion(image: "Sad", text: "슬퍼요"), Emotion(image: "Angry", text: "화나요")]
    let plusEmotions = [
        Emotion(image: "Happy", text: "행복해요"), Emotion(image: "Proud", text: "뿌듯해요"), Emotion(image: "Meh", text: "그저 그래요"), Emotion(image: "Tired", text: "피곤해요"), Emotion(image: "Sad", text: "슬퍼요"), Emotion(image: "Angry", text: "화나요"),
        Emotion(image: "Excited", text: "설레요"), Emotion(image: "Thrilled", text: "신나요"), Emotion(image: "Relaxed", text: "편안해요"), Emotion(image: "Lethargic", text: "무기력해요"), Emotion(image: "Lonely", text: "외로워요"), Emotion(image: "Complicated", text: "복잡해요")
    ]
    var questionDate: String? = Date().getQuestionDate()
    var isFull: Bool = false
    
    
    // inputs
    var inputs: AnswerViewModelInputs
    
    // outputs
    var outputs: AnswerViewModelOutputs
    var changeQuestionSubject: PublishSubject<QuestionType>
    var foldViewSubject: PublishSubject<Bool>
    var inputTextRelay: BehaviorRelay<String>
    var tolggleSwitchSubject: BehaviorRelay<Void>
    var countTextRelay: BehaviorRelay<String>
    var toastSubject: PublishSubject<String>

    init() {
        switch IAPManager.getHasUserPurchased() {
        case true:
            emotions = plusEmotions
        case false:
            break
        }
    }

    func setDate(date: [Int]) {
        // 월 계산
        if date[1] < 10 {
            if date[2] < 10 {
                self.questionDate = "\(date[0])-0\(date[1])-0\(date[2])"
            } else {
                self.questionDate = "\(date[0])-0\(date[1])-\(date[2])"
            }
        } else {
            if date[2] < 10 {
                self.questionDate = "\(date[0])-\(date[1])-0\(date[2])"
            } else {
                self.questionDate = "\(date[0])-\(date[1])-\(date[2])"
            }
        }
    }
}
