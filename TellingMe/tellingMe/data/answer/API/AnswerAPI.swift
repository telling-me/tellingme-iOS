//
//  AnswerAPI.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation
import Moya

enum AnswerAPITarget {
    case getAnswerList(month: String, year: String)
    case getAnswer(query: String)
    case getAnswerRecord(query: String)
    case registerAnswer(request: RegisterAnswerRequest)
    case deleteAnswer(request: DeleteAnswerRequest)
    case updateAnswer(request: UpdateAnswerRequest)
}

extension AnswerAPITarget: TargetType {
    var task: Task {
        switch self {
        case .getAnswerList(let month, let year):
            return .requestParameters(parameters: ["month": month, "year": year], encoding: URLEncoding.queryString)
        case .getAnswer(let query):
            return .requestParameters(parameters: ["date": query], encoding: URLEncoding.queryString)
        case .getAnswerRecord(let query):
            return .requestParameters(parameters: ["date": query], encoding: URLEncoding.queryString)
        case .registerAnswer(let request):
            return .requestJSONEncodable(request)
        case .deleteAnswer(let request):
            return .requestJSONEncodable(request)
        case .updateAnswer(let request):
            return .requestJSONEncodable(request)
        }
    }

    var path: String {
        switch self {
        case .getAnswerList:
            return "api/answer/list"
        case .getAnswer:
            return "api/answer"
        case .getAnswerRecord:
            return "api/answer/record"
        case .registerAnswer:
            return "api/answer"
        case .deleteAnswer:
            return "api/answer/delete"
        case .updateAnswer:
            return "api/answer/update"
        }
    }

    var method: Moya.Method {
        switch self {
        case .registerAnswer:
            return .post
        case .deleteAnswer:
            return .delete
        case .updateAnswer:
            return .patch
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

    static func getAnswerList(month: String, year: String, completion: @escaping(Result<[AnswerListResponse]?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().listRequest(.getAnswerList(month: month, year: year), dtoType: AnswerListResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }

    static func getAnswer(query: String, completion: @escaping(Result<GetAnswerRespose?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getAnswer(query: query), dtoType: GetAnswerRespose.self, completion: completion)
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

    static func getAnswerRecord(query: String, completion: @escaping(Result<AnswerRecordResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getAnswerRecord(query: query), dtoType: AnswerRecordResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }

    static func deleteAnswer(request: DeleteAnswerRequest, completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.deleteAnswer(request: request), dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }

    static func updateAnswer(request: UpdateAnswerRequest, completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.updateAnswer(request: request), dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
}
