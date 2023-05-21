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
        dtoType: Data.Type,
        completion: @escaping (Result<Data?, APIError>) -> Void
    ) {
        self.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    if response.data.isEmpty {
                        completion(.success(nil))
                    } else {
                        if let errorResponse = try? JSONDecoder().decode(ErrorData.self, from: response.data) {
                            completion(.failure(APIError.errorData(errorResponse)))
                        } else {
                            let data = try JSONDecoder().decode(Data.self, from: response.data)
                            completion(.success(data))
                        }
                    }
                } catch {
                    completion(.failure(APIError.other(error)))
                }
            case let .failure(error):
                completion(.failure(APIError.other(error)))
            }
        }
    }

    func request(
        _ target: Target,
        dtoType: Data.Type,
        completion: @escaping (Result<Data?, APIError>) -> Void
    ) {
        self.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    if response.data.isEmpty {
                        completion(.success(nil))
                    } else {
                        let data = try JSONDecoder().decode(Data.self, from: response.data)
                        completion(.success(data))
                    }
                } catch {
                    if let errorResponse = try? JSONDecoder().decode(ErrorData.self, from: response.data) {
                        completion(.failure(APIError.errorData(errorResponse)))
                    } else {
                        completion(.failure(APIError.other(error)))
                    }
                }
            case let .failure(error):
                completion(.failure(APIError.other(error)))
            }
        }
    }
    
    func listRequest<T: Codable>(
        _ target: Target,
        dtoType: T.Type,
        completion: @escaping (Result<[T]?, APIError>) -> Void
    ) {
        self.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    if response.data.isEmpty {
                        completion(.success(nil))
                    } else {
                        if let errorResponse = try? JSONDecoder().decode(ErrorData.self, from: response.data) {
                            completion(.failure(APIError.errorData(errorResponse)))
                        } else {
                            let data = try JSONDecoder().decode([T].self, from: response.data)
                            completion(.success(data))
                        }
                    }
                } catch{
                    completion(.failure(APIError.other(error)))
                }
            case let .failure(error):
                completion(.failure(APIError.other(error)))
            }
        }
    }
}
