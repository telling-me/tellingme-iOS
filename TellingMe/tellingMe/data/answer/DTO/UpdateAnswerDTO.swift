//
//  UpdateAnswerDTO.swift
//  tellingMe
//
//  Created by 마경미 on 20.05.23.
//

import Foundation

struct UpdateAnswerRequest: Codable {
    let date: String
    let content: String
}
