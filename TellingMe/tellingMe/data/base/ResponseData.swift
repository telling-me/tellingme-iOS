//
//  ResponseData.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

enum APIError: Error {
    case errorData(ErrorData)
    case tokenNotFound
    case notJoin(OauthErrorResponse)
    case other(Error)
}

struct EmptyResponse: Codable {
}

struct IntData: Decodable {
    let value: Int
}

struct Success<Data: Codable>: Codable {
    let data: Data
}

struct ErrorData: Codable {
    let status: Int
    let code: String
    let message: String
}

//enum APIError: Error {
//    case http(ErrorData)
//    case unknown(Error)
//}
