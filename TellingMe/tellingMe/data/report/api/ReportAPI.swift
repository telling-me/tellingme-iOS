//
//  ReportAPI.swift
//  tellingMe
//
//  Created by 마경미 on 09.08.23.
//

import Foundation
import Moya

enum ReportAPITarget {
    case postReport(ReportRequest)
}

extension ReportAPITarget: TargetType {
    var task: Task {
        switch self {
        case .postReport(let body):
            return .requestJSONEncodable(body)
        default:
            return .requestPlain
        }
    }

    var path: String {
        switch self {
        case .postReport:
            return "api/report"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postReport:
            return .post
        default:
            return .get
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
        default:
            return nil
        }
    }
}

struct ReportAPI: Networkable {
    typealias Target = ReportAPITarget

    static func postReport(request: ReportRequest, completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.postReport(request), dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
}
