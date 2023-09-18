//
//  ShareAPI.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/17.
//

import Foundation

import Moya
import RxMoya
import RxSwift

enum ShareAPITarget {
    case postSharedType(ShareTypeRequest)
}

extension ShareAPITarget: TargetType {
    var path: String {
        switch self {
        case .postSharedType(let type):
            return "api/mypage/\(type)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSharedType:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postSharedType:
            return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
     }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}

struct ShareAPI: Networkable {
    typealias Target = ShareAPITarget
    
    static func postShareType(request: ShareTypeRequest) -> Observable<EmptyResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .postSharedType(request))
        } catch let error {
            print(error)
            print("Error getting Sharing Provider.")
            return Observable.error(APIError.tokenNotFound)
        }
    }
}
