//
//  SignUpDTO.swift
//  tellingMe
//
//  Created by 마경미 on 08.04.23.
//

import Foundation
import KeychainSwift

struct SignUpRequest: Codable {
    var allowNotification: Bool
    var pushToken: String?
    var nickname: String
    var purpose: String
    var job: Int
    var jobInfo: String?
    var gender: String?
    var birthDate: String?
    var mbti: String?
    var socialId: String
    var socialLoginType: String
}

struct SignUpResponse: Codable {
    let statusCode: Int
}
