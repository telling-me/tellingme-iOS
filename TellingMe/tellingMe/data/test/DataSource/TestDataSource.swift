//
//  TestDataSource.swift
//  tellingMe
//
//  Created by 마경미 on 20.03.23.
//

import Foundation
import Moya

enum TestAPITarget {
    case test(TestRequest)
}

extension TestAPITarget: TargetType {
    var headers: [String: String]? {
        return nil
    }

    var task: Task {
        .requestPlain
    }

    var path: String {
        switch self {
        case .test:
            return ""
        }
    }

    var method: Moya.Method {
        return .get
    }
}

struct TestAPI: Networkable {
    typealias Target = TestAPITarget

    /// page에 해당하는 User 정보 조회
    static func getTest(request: TestRequest, completion: @escaping (_ succeed: TestResponse?, _ failed: Error?) -> Void) {
        makeProvider().request(.test(request)) { result in
            switch ResponseData<TestResponse>.processJSONResponse(result) {
            case .success(let model): return completion(model, nil)
            case .failure(let error): return completion(nil, error)
            }
        }
    }
}
