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

    let emotions = [Emotion(image: "Happy", text: "행복해요"), Emotion(image: "Proud", text: "뿌듯해요"), Emotion(image: "Meh", text: "그저 그래요"), Emotion(image: "Tired", text: "피곤해요"), Emotion(image: "Sad", text: "슬퍼요"), Emotion(image: "Angry", text: "화나요")]
    var selectedEmotion: Int? = nil
    let emotionCount: Int

    init() {
        emotionCount = emotions.count
    }
}
