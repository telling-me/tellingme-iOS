//
//  RegisterAnswerDTO.swift
//  tellingMe
//
//  Created by 마경미 on 20.05.23.
//

import Foundation

struct RegisterAnswerRequest: Codable {
    let content: String
    let emotion: Int
}
