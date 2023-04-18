//
//  NetworkLoggerPlugin.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Alamofire

class LoggingInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }

    func retry(_ request: any Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }

    func intercept(_ request: URLRequest, for session: Session, response: HTTPURLResponse?, data: Data?, error: Error?, completion: @escaping (URLRequest?, Error?) -> Void) {
        print("----- Request -----")
        print(request.httpMethod ?? "")
        print(request.url?.absoluteString ?? "")
        if let headers = request.allHTTPHeaderFields {
            print(headers)
        }
        if let body = request.httpBody {
            print(String(data: body, encoding: .utf8) ?? "")
        }
        if let response = response {
            print("----- Response -----")
            print(response.statusCode)
            if let headers = response.allHeaderFields as? [String: String] {
                print(headers)
            }
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "")
            }
        }
        completion(request, error)
    }
}

let loggingInterceptor = LoggingInterceptor()
let session = Session(interceptor: loggingInterceptor)
