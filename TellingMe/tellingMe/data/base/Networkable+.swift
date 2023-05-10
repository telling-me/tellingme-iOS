//
//  Networkable.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya
//
//protocol Networkable {
//    associatedtype Target: TargetType
//    static func makeProvider() -> MoyaProvider<Target>
//}
//
//extension Networkable {
//
//    static func makeProvider() -> MoyaProvider<Target> {
//        let loggerPlugin = NetworkLoggerPlugin()
//        return MoyaProvider<Target>(plugins: [loggerPlugin])
//    }
//}

protocol Networkable {
    associatedtype Target: TargetType
//    static func makeProvider() -> MoyaProvider<Target>
}

extension Networkable {
    static func makeAuthorizedProvider() throws -> MoyaProvider<Target> {
        let loggerPlugin = NetworkLoggerPlugin()
        var plugins: [PluginType] = [loggerPlugin]
        
        guard let accessToken = KeychainManager.shared.load(key: "accessToken") else {
            throw APIError.tokenNotFound
        }
        
        let authPlugin = AuthPlugin(token: accessToken)
        plugins.append(authPlugin)
        
        return MoyaProvider<Target>(plugins: plugins)
    }
    
    static func makeUnauthorizedProvider() -> MoyaProvider<Target> {
        let loggerPlugin = NetworkLoggerPlugin()
        let plugins: [PluginType] = [loggerPlugin]
        
        return MoyaProvider<Target>(plugins: plugins)
    }
    
}

final class AuthPlugin: PluginType {
    var token: String?
    
    init(token: String? = nil) {
        self.token = token
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let token = token {
            request.addValue(token, forHTTPHeaderField: "accessToken")
        }
        return request
    }
}
