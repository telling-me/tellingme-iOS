//
//  FeedbackRequestDTO.swift
//  tellingMe
//
//  Created by 마경미 on 24.09.23.
//

import Foundation

// MARK: 질문 피드백 팝업 결과를 보내는 요청 모델입니다.
struct QuestionFeedbackRequest: Codable {
    let date: String
    let isPositive: Bool
    let question1: Int?
    let question2: Int?
    let question3: Int?
    let reason: String?
    let other: String?
    let etc: String?
}

// MARK: 질문 피드백 팝업 결과 요청에 대한 응답 모델입니다.
struct QuestionFeedbackResponse: Codable {
    let date: String
    let isPositive: Bool
    let question1: Int
    let question2: Int
    let question3: Int
    let reason: String
    let other: String
    let etc: String
}
