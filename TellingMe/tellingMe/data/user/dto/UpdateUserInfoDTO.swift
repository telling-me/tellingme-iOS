//
//  UpdateUserInfoDTO.swift
//  tellingMe
//
//  Created by 마경미 on 31.05.23.
//

import Foundation

struct UpdateUserInfoRequest: Codable {
    let birthDate: String?
    let gender: String?
    let job: Int
    let jobInfo: String?
    let mbti: String?
    let nickname: String
    let purpose: String
}
