//
//  ResponseData.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

struct ResponseData<Model: Codable> {
    struct CommonResponse: Codable {
        let result: Model
    }

    static func processResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, Error> {
        switch result {
        case .success(let response):
            do {
                _ = try response.filterSuccessfulStatusCodes()

                let commonResponse = try JSONDecoder().decode(CommonResponse.self, from: response.data)
                return .success(commonResponse.result)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }

//    static func processTestResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, Error> {
//        switch result {
//        case .success(let response):
//            let commonResponse: CommonResponse
//            do {
//                _ = try response.filterSuccessfulStatusCodes()
//                commonResponse = try JSONDecoder().decode(CommonResponse.self, from: response.data)
//
//
//                return .success(commonResponse.result)
//            } catch {
//                let moyaError: MoyaError? = error as? MoyaError
//                let response: Response? = moyaError?.response
//                let statusCode: Int? = response?.statusCode
//
//                let customError = CustomError(statusCode: statusCode ?? 0, result: commonResponse)
//                return .failure(statusCode, )
//            }
//        case .failure(let error):
//            return .failure(error)
//        }
//    }

    static func processJSONResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, Error> {
        switch result {
        case .success(let response):
            do {
                let model = try JSONDecoder().decode(Model.self, from: response.data)
                return .success(model)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
