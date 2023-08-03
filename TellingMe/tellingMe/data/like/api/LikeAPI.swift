//
//  LikeAPI.swift
//  tellingMe
//
//  Created by 마경미 on 03.08.23.
//

import Foundation
import Moya

enum LikeAPITarget {
    case postLike(LikeRequest)
}

extension LikeAPITarget: TargetType {
    var task: Task {
        switch self {
        case .postLike(let body):
            return .requestJSONEncodable(body)
        default:
            return .requestPlain
        }
    }

    var path: String {
        switch self {
        case .postLike:
            return "api/likes"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postLike:
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

struct LikeAPI: Networkable {
    typealias Target = LikeAPITarget

    // date를 query로 보내서 요청
    static func postLike(request: LikeRequest, completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.postLike(request), dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
}
