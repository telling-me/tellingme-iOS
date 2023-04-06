//
//  TestDataSource.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

enum TestAPITarget {
    case test
    case oauthTest(loginType: String, body: OauthTestRequest)
}

extension TestAPITarget: TargetType {
    var headers: [String: String]? {
        return nil
    }

    var task: Task {
        switch self {
        case .test:
            return .requestPlain
        case .oauthTest(_, let body):
            return .requestJSONEncodable(body)
        }
    }

    var path: String {
        switch self {
        case .test:
            return ""
        case .oauthTest(let type, _):
            return "api/oauth/\(type)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .test:
            return .get
        case .oauthTest:
            return .post
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .oauthTest:
            return JSONEncoding.default
        case .test:
            return JSONEncoding.default
        }
     }
}

struct TestAPI: Networkable {
    typealias Target = TestAPITarget

    /// page에 해당하는 User 정보 조회
    static func getTest(request: TestRequest, completion: @escaping (_ succeed: TestResponse?, _ failed: Error?) -> Void) {
        makeProvider().request(.test) { result in
            switch ResponseData<TestResponse>.processJSONResponse(result) {
            case .success(let model): return completion(model, nil)
            case .failure(let error): return completion(nil, error)
            }
        }
    }

    static func oauthTest(type: String, request: OauthTestRequest, completion: @escaping (_ succeed: OauthTestResponse?, _ failed: Error?) -> Void) {
        makeProvider().request(.oauthTest(loginType: type, body: request)) { result in
            switch ResponseData<OauthTestResponse>.processResponse(result) {
            case let .success(model): return completion(model, nil)
            case let .failure(error): return completion(nil, error)
            }
        }
    }
}
