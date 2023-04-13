//
//  TestDataSource.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

enum SignAPITarget {
    case oauth(loginType: String, body: OauthRequest)
    case signUp(SignUpRequest)
    case checkNickname(CheckNicknameRequest)
}

extension SignAPITarget: TargetType {
    var headers: [String: String]? {
        return nil
    }

    var task: Task {
        switch self {
        case .oauth(_, let body):
            return .requestJSONEncodable(body)
        case .signUp(let body):
            return .requestJSONEncodable(body)
        case .checkNickname(let body):
            return .requestJSONEncodable(body)
        }
    }

    var path: String {
        switch self {
        case .oauth(let type, _):
            return "api/oauth/\(type)"
        case .signUp:
            return "api/oauth/join"
        case .checkNickname:
            return "api/oauth/nickname"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
     }
}

struct SignAPI: Networkable {
    typealias Target = SignAPITarget

    static func postOauth(type: String, request: OauthRequest, completion: @escaping (Result<OauthResponse, Error>) -> Void) {
        makeProvider().requestWithError(.oauth(loginType: type, body: request), completion: completion)
    }

    static func postSignUp(request: SignUpRequest, completion: @escaping (Result<SignUpResponse, Error>) -> Void) {
        makeProvider().request(.signUp(request), completion: completion)
    }
    
    static func checkNickname(request: CheckNicknameRequest, completion: @escaping (Result<CheckNicknameResponse,Error>) -> Void) {
        makeProvider().request(.checkNickname(request), completion: completion)
    }
}
