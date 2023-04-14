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
}

struct CheckNicknameErrorResponse: Error {
    let status: Int
    let code: String
    let message: String
}
