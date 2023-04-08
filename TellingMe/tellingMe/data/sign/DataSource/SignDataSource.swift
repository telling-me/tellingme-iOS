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
        }
    }

    var path: String {
        switch self {
        case .oauth(let type, _):
            return "api/oauth/\(type)"
        case .signUp:
            return "api/oauth/join"
        }
    }

    var method: Moya.Method {
        switch self {
        case .oauth:
            return .post
        case .signUp:
            return .post
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .oauth:
            return JSONEncoding.default
        case .signUp(_):
            return JSONEncoding.default
        }
     }
}

struct SignAPI: Networkable {
    typealias Target = SignAPITarget

//    /// page에 해당하는 User 정보 조회
//    static func getTest(request: TestRequest, completion: @escaping (_ succeed: TestResponse?, _ failed: Error?) -> Void) {
//        makeProvider().request(.test) { result in
//            switch ResponseData<TestResponse>.processJSONResponse(result) {
//            case .success(let model): return completion(model, nil)
//            case .failure(let error): return completion(nil, error)
//            }
//        }
//    }

//    static func oauthTest(type: String, request: OauthTestRequest, completion: @escaping (_ succeed: OauthTestResponse?, _ failed: ErrorResponse?) -> Void) {
//        makeProvider().request(.oauthTest(loginType: type, body: request)) { result in
//            switch ResponseData<OauthTestResponse>.processResponse(result) {
//            case let .success(response):
//                do {
//                let response = try JSONDecoder().decode(OauthTestResponse.self, from: response.data)
//                } catch {
//                    return completion(response, nil)
//                }
//            case let .failure(error):
//                let errorResponse: ErrorResponse
//                do {
//                    let moyaError: MoyaError? = error as? MoyaError
//                    let response: Response? = moyaError?.response
//                    let statusCode = response?.statusCode
//                    let body = try JSONDecoder().decode(OauthTestResponse.self, from: )
////                    print(body.unsafelyUnwrapped as? Dictionary<String, Any>)
//                    errorResponse = ErrorResponse(statusCode: statusCode!, oAuthResponse: body)
//                } catch {
//                    return completion(nil, nil)
//                }
//                return completion(nil, errorResponse)
//            }
//        }
//    }

    static func postOauth(type: String, request: OauthRequest, completion: @escaping (Result<OauthResponse, Error>) -> Void) {
        makeProvider().requestWithError(.oauth(loginType: type, body: request), completion: completion)
    }

    static func postSignUp(request: SignUpRequest, completion: @escaping (Result<SignUpResponse, Error>) -> Void) {
        makeProvider().request(.signUp(request), completion: completion)
    }
}
