//
//  AnswerViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 21.05.23.
//

import Foundation

class AnswerViewModel {
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
