//
//  TestDTO.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

struct OauthRequest: Codable {
    let socialId: String
}

struct OauthResponse: Codable {
    let socialId: String
    let socialLoginType: String
}

struct OauthErrorResponse: Error, Codable {
    let socialId: String
    let socialLoginType: String
}
