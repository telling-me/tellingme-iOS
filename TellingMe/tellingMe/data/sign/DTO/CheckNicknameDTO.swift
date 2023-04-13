//
//  CheckNicknameDTO.swift
//  tellingMe
//
//  Created by 마경미 on 13.04.23.
//

import Foundation

struct CheckNicknameRequest: Codable {
    var nickname: String
}

struct CheckNicknameResponse: Codable {
    let statusCode: Int?
}
