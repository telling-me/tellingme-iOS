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
}
