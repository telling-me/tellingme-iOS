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

    let emotions = [Emotion(image: "Heart", text: "행복해요"), Emotion(image: "Heart", text: "뿌듯해요"), Emotion(image: "Heart", text: "그저 그래요"), Emotion(image: "Heart", text: "피곤해요"), Emotion(image: "Heart", text: "슬퍼요"), Emotion(image: "Heart", text: "화나요"), Emotion(image: "Heart", text: "설레요"), Emotion(image: "Heart", text: "신나요"), Emotion(image: "Heart", text: "편안해요"), Emotion(image: "Heart", text: "무기력해요"), Emotion(image: "Heart", text: "외로워요"), Emotion(image: "Heart", text: "복잡해요")]
    var selectedEmotion: Int? = nil
    let emotionCount: Int

    init() {
        emotionCount = emotions.count
    }
}
