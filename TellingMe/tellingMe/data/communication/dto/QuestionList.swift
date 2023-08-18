//
//  QuestionListRequest.swift
//  tellingMe
//
//  Created by 마경미 on 24.07.23.
//

import Foundation

struct QuestionListRequest: Codable {
    // 오늘 날짜를 2023-05-24식으로 넘겨주면 오늘로부터 3일까지 이전 question을 받을 수 있음
    let date: String
}

struct QuestionListResponse: Codable {
    let title: String
    let date: [Int]
    let answerCount: Int
    let phrase: String
}

extension QuestionListResponse {
    static var defaultQuestion: QuestionListResponse {
        return QuestionListResponse(title: "텔링미를 사용하실 때 드는 기분은?", date: [2023, 03, 01], answerCount: 1, phrase: "하루 한번, 질문에 답변하며 나를 깨닫는 시간")
    }
}
