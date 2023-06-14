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
    case withdrawalUser
    case logout

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
        default:
            return .requestPlain
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
        case .withdrawalUser:
            return "api/oauth/withdraw"
        case .logout:
            return "api/oauth/logout"
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

    static func postKakaoOauth(type: String, request: OauthRequest, completion: @escaping (Result<OauthResponse?, APIError>) -> Void) {
        makeUnauthorizedProvider().request(.kakao(loginType: type, body: request), dtoType: OauthResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                switch error {
                case let .other(otherError):
                    let error = otherError as? MoyaError
                    if let data = error?.response?.data {
                        let errorResponse = try? JSONDecoder().decode(OauthErrorResponse.self, from: data)
                        completion(.failure(APIError.notJoin(errorResponse!)))
                    } else {
                        completion(.failure(APIError.other(otherError)))
                    }
                case .errorData(let errorData):
                    completion(.failure(APIError.errorData(errorData)))
                default:
                    completion(.failure(APIError.other(error)))
                }
            }
        }
    }

    static func postAppleOauth(type: String, token: String, request: OauthRequest, completion: @escaping (Result<OauthResponse?, APIError>) -> Void) {
        makeUnauthorizedProvider().request(.apple(token: token, loginType: type, body: request), dtoType: OauthResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                switch error {
                case let .other(otherError):
                    let error = otherError as? MoyaError
                    if let data = error?.response?.data {
                        let errorResponse = try? JSONDecoder().decode(OauthErrorResponse.self, from: data)
                        completion(.failure(APIError.notJoin(errorResponse!)))
                    } else {
                        completion(.failure(APIError.other(otherError)))
                    }
                case .errorData(let errorData):
                    completion(.failure(APIError.errorData(errorData)))
                default:
                    completion(.failure(APIError.other(error)))
                }
            }
        }
    }
    static func postSignUp(request: SignUpRequest, completion: @escaping (Result<SignUpResponse?, APIError>) -> Void) {
        makeUnauthorizedProvider().request(.signUp(request), dtoType: SignUpResponse.self, completion: completion)
    }

    static func checkNickname(request: CheckNicknameRequest, completion: @escaping (Result<CheckNicknameResponse?, APIError>) -> Void) {
        makeUnauthorizedProvider().request(.checkNickname(request), dtoType: CheckNicknameResponse.self, completion: completion)
    }

    static func postJobInfo(request: JobInfoRequest, completion: @escaping (Result<JobInfoResponse?, APIError>) -> Void) {
        makeUnauthorizedProvider().request(.jobInfo(request), dtoType: JobInfoResponse.self, completion: completion)
    }
    
    static func withdrawalUser(completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.withdrawalUser, dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
    
    static func logout(completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.logout, dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
}
