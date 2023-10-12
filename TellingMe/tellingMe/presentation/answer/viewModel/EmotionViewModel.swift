//
//  EmotionViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import Foundation

class EmotionViewModel {
    struct Emotion {
        let image: String
        let text: String
    }

    var emotions = [Emotion(image: "Happy", text: "행복해요"), Emotion(image: "Proud", text: "뿌듯해요"), Emotion(image: "Meh", text: "그저 그래요"), Emotion(image: "Tired", text: "피곤해요"), Emotion(image: "Sad", text: "슬퍼요"), Emotion(image: "Angry", text: "화나요")]
    let plusEmotions = [
        Emotion(image: "Happy", text: "행복해요"), Emotion(image: "Proud", text: "뿌듯해요"), Emotion(image: "Meh", text: "그저 그래요"), Emotion(image: "Tired", text: "피곤해요"), Emotion(image: "Sad", text: "슬퍼요"), Emotion(image: "Angry", text: "화나요"),
        Emotion(image: "Excited", text: "설레요"), Emotion(image: "Thrilled", text: "신나요"), Emotion(image: "Relaxed", text: "편안해요"), Emotion(image: "Lethargic", text: "무기력해요"), Emotion(image: "Lonely", text: "외로워요"), Emotion(image: "Complicated", text: "복잡해요")
    ]
    var selectedEmotion: Int? = nil
    let emotionCount: Int

    init() {
        switch IAPManager.getHasUserPurchased() {
        case true:
            emotions = plusEmotions
        case false:
            break
        }
        emotionCount = emotions.count
        print(emotionCount, "🚩 emotion count")
    }
}
