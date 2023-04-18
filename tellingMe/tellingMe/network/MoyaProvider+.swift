//
//  MoyaProvider+.swift
//  tellingMe
//
//  Created by 마경미 on 07.04.23.
//

import Foundation
import Moya

extension MoyaProvider {
    func request<Data: Codable>(
        _ target: Target,
        completion: @escaping (Result<Data?, Error>) -> Void
    ) {
        self.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    if response.data.isEmpty {
                        completion(.success(nil))
                    } else {
                        let success = try JSONDecoder().decode(Success<Data>.self, from: response.data)
                        completion(.success(success.data))
                    }
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func requestWithError<Data: Codable>(
        _ target: Target,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        self.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    _  = try response.filterSuccessfulStatusCodes()
                    let success = try JSONDecoder().decode(Success<Data>.self, from: response.data)
                    completion(.success(success.data))
                } catch {
                    if let moyaError = error as? MoyaError {
                        switch moyaError {
                        case .statusCode(let response):
                            if response.statusCode == 404 {
                                if let errorResponse = try? JSONDecoder().decode(OauthErrorResponse.self, from: response.data) {
                                    completion(.failure(errorResponse))
                                    return
                                }
                            }
                        default:
                            break
                        }
                    }
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
