//
//  AnswerAPI.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation
import Moya

enum AnswerAPITarget {
    case getAnswerList(query: String)
}

extension AnswerAPITarget: TargetType {
    var task: Task {
        switch self {
        case .getAnswerList(let query):
            return .requestParameters(parameters: ["date":query], encoding: URLEncoding.queryString)
        }
    }

    var path: String {
        switch self {
        case .getAnswerList:
            return "api/answer/list"
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

struct AnswerAPI: Networkable {
    typealias Target = AnswerAPITarget

//    static func getTodayQuestion(completion: @escaping(Result<QuestionResponse?, APIError>) -> Void) {
//        makeProvider().request(.getTodayQuestion, dtoType: QuestionResponse.self, completion: completion)
//    }
    
    static func getAnswerList(query: String, completion: @escaping(Result<[AnswerListResponse]?, APIError>) -> Void) {
        makeProvider().listRequest(.getAnswerList(query: query), dtoType: AnswerListResponse.self, completion: completion)
    }
}
