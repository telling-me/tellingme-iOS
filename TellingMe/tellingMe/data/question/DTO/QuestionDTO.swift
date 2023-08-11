//
//  QuestionRequest.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import Foundation
import Moya

struct QuestionResponse: Codable {
    let date: [Int]
    let title: String
    let phrase: String
}

extension QuestionResponse {
    static var standardQuestion: QuestionResponse {
        return QuestionResponse(date: [2023,03,01], title: "텔링미를 사용할 때 드는 기분은?", phrase: "하루에 한 번 질문에 답하고 시간")
    }
}
