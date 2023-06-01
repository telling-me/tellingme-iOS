//
//  getUserDTO.swift
//  tellingMe
//
//  Created by 마경미 on 31.05.23.
//

import Foundation

struct UserInfoResponse: Codable {
    let nickname: String
    let birthDate: [Int]?
    let purpose: String
    let job: Int
    let gender: String?
    let jobInfo: String?
    let mbti: String?
}
