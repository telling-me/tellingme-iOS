//
//  Networkable.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

protocol Networkable {
    associatedtype Target: TargetType
    static func makeProvider() -> MoyaProvider<Target>
}

extension Networkable {

    static func makeProvider() -> MoyaProvider<Target> {
        let loggerPlugin = NetworkLoggerPlugin()
        return MoyaProvider<Target>(plugins: [loggerPlugin])
    }
}
