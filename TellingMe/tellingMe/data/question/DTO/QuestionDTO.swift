//
//  QuestionRequest.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import Foundation
import Moya

struct QuestionRequest: Codable {
}

struct QuestionResponse: Codable {
    let date: [Int]
    let title: String
    let phrase: String
}
