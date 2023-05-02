//
//  TestDataSource.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

enum LoginAPITarget {
    case kakao(loginType: String, body: OauthRequest)
    case apple(token: String, loginType: String, body: OauthRequest)
    case signUp(SignUpRequest)
    case checkNickname(CheckNicknameRequest)
    case jobInfo(JobInfoRequest)
}

extension LoginAPITarget: TargetType {
    var task: Task {
        switch self {
        case .kakao(_, let body):
            return .requestJSONEncodable(body)
        case .apple(_, _, let body):
             return .requestJSONEncodable(body)
        case .signUp(let body):
            return .requestJSONEncodable(body)
        case .checkNickname(let body):
            return .requestJSONEncodable(body)
        case .jobInfo(let body):
            return .requestJSONEncodable(body)
        }
    }

    var path: String {
        switch self {
        case .kakao(let type, _), .apple(_, let type, _):
            return "api/oauth/\(type)"
        case .signUp:
            return "api/oauth/join"
        case .checkNickname:
            return "api/oauth/nickname"
        case .jobInfo:
            return "api/oauth/jobName"
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

    var headers: [String: String]? {
        switch self {
        case .apple(let token, _, _):
            return ["idToken": token, "Content-Type": "application/json"]
        default:
            return nil
        }
    }
}

struct LoginAPI: Networkable {
    typealias Target = LoginAPITarget

    static func postKakaoOauth(type: String, request: OauthRequest, completion: @escaping (Result<OauthResponse?, Error>) -> Void) {
        makeProvider().request(.kakao(loginType: type, body: request), dtoType: OauthResponse.self, completion: completion)
    }

    static func postAppleOauth(type: String, token: String, request: OauthRequest, completion: @escaping (Result<OauthResponse?, Error>) -> Void) {
        makeProvider().request(.apple(token: token, loginType: type, body: request), dtoType: OauthResponse.self, completion: completion)
    }
    static func postSignUp(request: SignUpRequest, completion: @escaping (Result<SignUpResponse?, Error>) -> Void) {
        makeProvider().request(.signUp(request), dtoType: SignUpResponse.self, completion: completion)
    }

    static func checkNickname(request: CheckNicknameRequest, completion: @escaping (Result<CheckNicknameResponse?, Error>) -> Void) {
        makeProvider().request(.checkNickname(request), dtoType: CheckNicknameResponse.self, completion: completion)
    }

    static func postJobInfo(request: JobInfoRequest, completion: @escaping (Result<JobInfoResponse?, Error>) -> Void) {
        makeProvider().request(.jobInfo(request), dtoType: JobInfoResponse.self, completion: completion)
    }
}
