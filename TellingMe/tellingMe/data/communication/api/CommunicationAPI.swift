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
    case getCommunicationList(date: String, page: Int, size: Int, sort: String)
}

extension CommuncationAPITarget: TargetType {
    var task: Task {
        switch self {
        case .getQuestionList(let query):
            return .requestParameters(parameters: ["date": query], encoding: URLEncoding.queryString)
        case .getCommunicationList(let date, let page, let size, let sort):
            return .requestParameters(parameters: ["date": date, "page": page, "size": size, "sort": sort], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var path: String {
        switch self {
        case .getQuestionList:
            return "api/communication"
        case .getCommunicationList:
            return "api/communication/list"
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

    static func getCommunicationList(date: String, page: Int, size: Int, sort: String, completion: @escaping(Result<CommunicationListResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getCommunicationList(date: date, page: page, size: size, sort: sort), dtoType: CommunicationListResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
}
