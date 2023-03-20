//
//  ResponseData.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

struct Success<Data: Codable>: Codable {
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

//struct ResponseData<Model: Codable> {
//    struct CommonResponse: Codable {
//        let result: Model
//    }
//
//    static func processResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, Error> {
//        switch result {
//        case .success(let response):
//            do {
//                // status code가 200...299인 경우만 success로 체크 (아니면 예외발생)
//                _ = try response.filterSuccessfulStatusCodes()
//
//                let commonResponse = try JSONDecoder().decode(CommonResponse.self, from: response.data)
//                return .success(commonResponse.result)
//            } catch {
//                return .failure(error)
//            }
//
//        case .failure(let error):
//            return .failure(error)
//        }
//    }
//
//    // CommonResponse 모델을 따르지 않는 모델을 처리하기 위한 함수
//        static func processJSONResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, Error> {
//            switch result {
//            case .success(let response):
//                do {
//                    let model = try JSONDecoder().decode(Model.self, from: response.data)
//                    return .success(model)
//                } catch {
//                    return .failure(error)
//                }
//            case .failure(let error):
//
//                return .failure(error)
//            }
//        }
//}
