//
//  ResponseData.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

struct EmptyResponse: Decodable {
}

struct Success<Data: Codable>: Codable {
    let data: Data
}


struct ErrorData: Codable, Error {
    let code: Int
    let message: String
    let data: Data
}

struct Failure: Codable {
    enum Case: Int, CaseIterable, Codable {
        case badRequest = 100
        case unauthorized = 101
        case forbidden = 102
        case notFound = 103
        case jwtExpired = 104
        case unsignedUser = 105
        case nicknameDuplicate = 110
        case userDuplicate = 111
        case badMethod = 198
        case internalServerError = 199
    }

    let `case`: Case
}

enum APIError: Error {
    case http(ErrorData)
    case unknown(Error)
}
