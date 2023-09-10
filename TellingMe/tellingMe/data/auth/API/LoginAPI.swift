//
//  TestDataSource.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

enum LoginAPITarget {
    case signIn(type:String, token: String)
    case autologin(type: String, body: AutologinRequest)
    case signUp(SignUpRequest)
    case checkNickname(CheckNicknameRequest)
    case jobInfo(JobInfoRequest)
    case withdrawalUser(WithdrawalRequest)
    case logout

}

extension LoginAPITarget: TargetType {
    var task: Task {
        switch self {
        case .autologin(_, let body):
            return .requestJSONEncodable(body)
        case .signUp(let body):
            return .requestJSONEncodable(body)
        case .checkNickname(let body):
            return .requestJSONEncodable(body)
        case .jobInfo(let body):
            return .requestJSONEncodable(body)
        case .withdrawalUser(let body):
            return .requestJSONEncodable(body)
        default:
            return .requestPlain
        }
    }

    var path: String {
        switch self {
        case .signIn(let type, _):
            return "api/oauth/\(type)/manual"
        case .autologin(let type, _):
            return "api/oauth/\(type)/auto"
        case .signUp:
            return "api/oauth/join"
        case .checkNickname:
            return "api/oauth/nickname"
        case .jobInfo:
            return "api/oauth/jobName"
        case .withdrawalUser:
            return "api/oauth/withdraw/app"
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
        case .signIn(_, let token):
            return ["oauthToken": token, "Content-Type": "application/json"]
        default:
            return nil
        }
    }
}

struct LoginAPI: Networkable {
    typealias Target = LoginAPITarget

    static func signIn(type: String, token: String, completion: @escaping (Result<SignInResponse?, APIError>) -> Void) {
        makeUnauthorizedProvider().request(.signIn(type: type, token: token), dtoType: SignInResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                switch error {
                case let .other(otherError):
                    let error = otherError as? MoyaError
                    if let data = error?.response?.data {
                        if let errorResponse = try? JSONDecoder().decode(SignInErrorResponse.self, from: data) {
                            completion(.failure(APIError.notJoin(errorResponse)))
                        } else {
                            completion(.failure(APIError.other(otherError)))
                        }
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
    
    static func signIn(type: String, token: String) -> Observable<SignInResponse> {
            let provider = makeUnauthorizedProvider()
            return provider.request(target: .signIn(type: type, token: token))
    }

    static func autologin(type: String, request: AutologinRequest, completion: @escaping (Result<SignInResponse?, APIError>) -> Void) {
        makeUnauthorizedProvider().request(.autologin(type: type, body: request), dtoType: SignInResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                switch error {
                case let .other(otherError):
                    let error = otherError as? MoyaError
                    if let data = error?.response?.data {
                        let errorResponse = try? JSONDecoder().decode(SignInErrorResponse.self, from: data)
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

    static func withdrawalUser(request: WithdrawalRequest, completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.withdrawalUser(request), dtoType: EmptyResponse.self, completion: completion)
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
