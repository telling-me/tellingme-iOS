//
//  AnswerListDTO.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation

struct AnswerListResponse: Codable {
    let emotion: Int
    let title: String
    let date: [Int]
}
