//
//  TestDTO.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

struct TestRequest: Codable {

}

struct TestResponse: Codable {
    let message: String
}

struct OauthTestRequest: Codable {
    let socialId: String
}

struct OauthTestResponse: Codable {
    let socialId: String
    let socialLoginType: String
}
