//
//  AnswerRecordDTO.swift
//  tellingMe
//
//  Created by 마경미 on 20.05.23.
//

import Foundation

struct AnswerRecordRequest: Codable {
    let date: String
}

struct AnswerRecordResponse: Codable {
    let count: Int
}
