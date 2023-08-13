//
//  Like.swift
//  tellingMe
//
//  Created by 마경미 on 03.08.23.
//

import Foundation

struct LikeRequest: Codable {
    let answerId: Int
}

struct LikeResponse: Codable {
    let isLiked: Bool
}
