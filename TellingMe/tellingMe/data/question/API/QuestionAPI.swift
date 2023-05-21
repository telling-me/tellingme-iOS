//
//  QuestionAPI.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import Foundation
import Moya

enum QuestionAPITarget {
    case getTodayQuestion
}

extension QuestionAPITarget: TargetType {
    var task: Task {
        switch self {
        case .getTodayQuestion:
            return .requestPlain
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

    static func getTodayQuestion(completion: @escaping(Result<QuestionResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getTodayQuestion, dtoType: QuestionResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
}
