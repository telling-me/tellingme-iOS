//
//  NetworkProvider.swift
//  tellingMe
//
//  Created by 마경미 on 18.04.23.
//

import Alamofire
import Combine
import Foundation

// MARK: - APIError

// 1. Error 타입 정의
enum APIError: Error {
    case http(ErrorData)
    case unknown(Error)
}

// MARK: - ErrorData

// 2. ErrorData 안에 들어갈 정보 선언
struct ErrorData: Codable {
    var statusCode: Int?
    var message: String
    var error: String?
}

// MARK: - NetworkProvider

struct NetworkProvider {
    // 4. Resonse 선언
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    func run<T: Decodable>(
        _ request: DataRequest,
        _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, APIError> {
        return request.validate().publishData(emptyResponseCodes: [200, 204, 205]).tryMap { result -> Response<T> in
            print(result)
            if let error = result.error {
                if let errorData = result.data {
                    let value = try decoder.decode(ErrorData.self, from: errorData)
                    throw APIError.http(value)
                } else {
                    throw error
                }
            }
            if let data = result.data {
                // 응답이 성공이고 result가 있을 때
                let value = try decoder.decode(T.self, from: data)
                return Response(value: value, response: result.response!)
            } else {
                // 응답이 성공이고 result가 없을 때 Empty를 리턴
                return Response(value: (Empty.emptyValue() as? T)!, response: result.response!)
            }
        }
        .mapError({ error -> APIError in
            if let apiError = error as? APIError {
                return apiError
            } else {
                return .unknown(error)
            }
        })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
