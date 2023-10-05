//
//  QuestionAPI.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import Foundation

import Moya
import RxSwift

enum QuestionAPITarget {
    case getTodayQuestion(query: String)
}

extension QuestionAPITarget: TargetType {
    var task: Task {
        switch self {
        case .getTodayQuestion(let query):
            return .requestParameters(parameters: ["date": query], encoding: URLEncoding.queryString)
        }
    }

    var path: String {
        switch self {
        case .getTodayQuestion:
            return "api/question"
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

struct QuestionAPI: Networkable {
    typealias Target = QuestionAPITarget

    static func getTodayQuestion(query: String, completion: @escaping(Result<QuestionResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getTodayQuestion(query: query), dtoType: QuestionResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }

    static func getTodayQuestion(query: String) -> Observable<QuestionResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .getTodayQuestion(query: query))
        } catch {
            print("Can't authroized")
            return Observable.error(APIError.tokenNotFound)
        }
    }
}
