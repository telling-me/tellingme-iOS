//
//  Request.swift
//  tellingMe
//
//  Created by 마경미 on 18.04.23.
//

import Foundation
import Alamofire
import Combine

typealias HTTPMethod = Alamofire.HTTPMethod
typealias Parameters = Alamofire.Parameters
typealias HTTPHeader = Alamofire.HTTPHeader

protocol Request {
    associatedtype Response: Decodable
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var parameters: Parameters { get }
    var headers: [HTTPHeader] { get }
}

extension Request {
    var method: HTTPMethod { return .get }
    var contentType: String { return "application/json" }
    var parameters: [String: Any]? { return nil }
    var headers: [HTTPHeader] { [] }

    // MARK: Internal
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: parameters)
        request.allHTTPHeaderFields = HTTPHeaders(headers).dictionary
        return request
    }

    // MARK: Private
    private func requestBodyFrom(params: Parameters) -> Data? {
        if params.isEmpty {
            return nil
        }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
}
