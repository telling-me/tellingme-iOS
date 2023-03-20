//
//  BaseTargetType.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

//protocol BaseTargetType: TargetType {
//}
//
//extension BaseTargetType {
//    var baseURL: URL {
//        // Configuration을 통해 phase별 baseURL 설정 방법: https://ios-development.tistory.com/660
////        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String else { fatalError("API URL not defined")}
////        gaurd let apiURL = URL(string: urlString) else { fatalError("URL is invalid") }
//
//        guard let apiURL = URL(string: Bundle.main.APIURL) else { fatalError("URL is invalid") }
//        return apiURL
//    }
//
////    var headers: [String: String]? {
////        var header = ["Content-Type": "application/json"]
////        let bundleVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
////        header["app-device-uuid"] = "uuid"
////        header["app-device-model-name"] = UIDevice.current.name
////        header["app-device-os-version"] = UIDevice.current.systemVersion
////        header["app-device-device-manufacturer"] = "apple"
////        header["app-version"] = bundleVersion
////        header["app-timezone-id"] = TimeZone.current.identifier
////        return header
////    }
//}

extension TargetType {
    var baseURL: URL {
        guard let apiURL = URL(string: Bundle.main.APIURL) else { fatalError("URL is invalid") }
        return apiURL
    }
    
    var sampleData: Data {
        return Data()
    }
}
