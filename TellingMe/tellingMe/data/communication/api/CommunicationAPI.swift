//
//  CommunicationAPI.swift
//  tellingMe
//
//  Created by 마경미 on 24.07.23.
//

import Foundation
import Moya

enum CommuncationAPITarget {
    case getQuestionList(query: String)
}

extension CommuncationAPITarget: TargetType {
    var task: Task {
        switch self {
        case .getQuestionList(let query):
            return .requestParameters(parameters: ["date": query], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var path: String {
        switch self {
        case .getQuestionList:
            return "api/communication"
        }
    }

    var method: Moya.Method {
        switch self {
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

struct CommunicationAPI: Networkable {
    typealias Target = CommuncationAPITarget

    // date를 query로 보내서 요청
    static func getQuestionList(query: String, completion: @escaping(Result<[QuestionListResponse]?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().listRequest(.getQuestionList(query: query), dtoType: QuestionListResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
}
