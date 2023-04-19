//
//  BaseTargetType.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

extension TargetType {
    var baseURL: URL {
        guard let apiURL = URL(string: Bundle.main.APIURL) else { fatalError("URL is invalid") }
        return apiURL
    }
    var sampleData: Data {
        return Data()
    }
}
