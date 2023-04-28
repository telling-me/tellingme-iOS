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
                        let data = try JSONDecoder().decode(Data.self, from: response.data)
                        completion(.success(data))
                    }
                } catch {
                    if let errorResponse = try? JSONDecoder().decode(ErrorData.self, from: response.data) {
                        completion(.failure(errorResponse))
                    } else {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}