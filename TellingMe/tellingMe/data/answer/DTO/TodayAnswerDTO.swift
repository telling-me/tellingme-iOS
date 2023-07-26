//
//  GetAnswerDTO.swift
//  tellingMe
//
//  Created by 마경미 on 20.05.23.
//

import Foundation

struct GetAnswerRespose: Codable {
    let answerId: Int
    let content: String
    let emotion: Int
    let likeCount: Int
    let isLiked: Bool
    let isPublic: Bool
}
