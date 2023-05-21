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
    case getTodayAnswer
    case getAnswerRecord
    case registerAnswer(request: RegisterAnswerRequest)
}

extension AnswerAPITarget: TargetType {
    var task: Task {
        switch self {
        case .getAnswerList(let query):
            return .requestParameters(parameters: ["date":query], encoding: URLEncoding.queryString)
        case .registerAnswer(let request):
            return .requestJSONEncodable(request)
        default:
            return .requestPlain
        }
    }

    var path: String {
        switch self {
        case .getAnswerList:
            return "api/answer/list"
        case .getTodayAnswer:
            return "api/answer"
        case .getAnswerRecord:
            return "api/answer/record"
        case .registerAnswer:
            return "api/answer"
        }
    }

    var method: Moya.Method {
        switch self {
        case .registerAnswer:
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

struct AnswerAPI: Networkable {
    typealias Target = AnswerAPITarget

    static func getAnswerList(query: String, completion: @escaping(Result<[AnswerListResponse]?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().listRequest(.getAnswerList(query: query), dtoType: AnswerListResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }

    static func getTodayAnswer(completion: @escaping(Result<TodayAnswerRespose?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getTodayAnswer, dtoType: TodayAnswerRespose.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
    
    static func registerAnswer(request: RegisterAnswerRequest, completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.registerAnswer(request: request), dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }

//    static func getAnswerRecord(completion: @escaping(Result<Int?, APIError>) -> Void) {
//        do {
//            try makeAuthorizedProvider().request(.getAnswerRecord, completion: completion)
//        } catch APIError.tokenNotFound {
//            completion(.failure(APIError.tokenNotFound))
//        } catch APIError.errorData(let error) {
//            completion(.failure(APIError.errorData(error)))
//        } catch {
//            completion(.failure(APIError.other(error)))
//        }
//    }
}
