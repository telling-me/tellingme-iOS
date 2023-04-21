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
    let status: Int
    let code: String
    let message: String
}

enum APIError: Error {
    case http(ErrorData)
    case unknown(Error)
}
