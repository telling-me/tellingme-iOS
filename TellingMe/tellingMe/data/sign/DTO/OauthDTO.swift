//
//  TestDTO.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

struct AutologinRequest: Codable {
    let socialId: String?
}

struct SignInResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let socialId: String
}

struct SignInErrorResponse: Error, Codable {
    let socialId: String
    let socialLoginType: String
}
