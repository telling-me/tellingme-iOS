//
//  UserAPI.swift
//  tellingMe
//
//  Created by 마경미 on 31.05.23.
//

import Foundation
import Moya

enum UserAPITarget {
    case getUserInfo
    case updateUserInfo(UpdateUserInfoRequest)
    case withdrawalUser
    case logout
}

extension UserAPITarget: TargetType {
    var task: Task {
        switch self {
        case .updateUserInfo(let body):
            return .requestJSONEncodable(body)
        default:
            return .requestPlain
        }
    }

    var path: String {
        switch self {
        case .getUserInfo:
            return "api/user"
        case .updateUserInfo:
            return "api/user/update"
        case .withdrawalUser:
            return "api/user/withdraw"
        case .logout:
            return "api/user/logout"
        }
    }

    var method: Moya.Method {
        switch self {
        case .updateUserInfo:
            return .patch
        case .withdrawalUser, .logout:
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

struct UserAPI: Networkable {
    typealias Target = UserAPITarget

    static func getUserInfo(completion: @escaping(Result<UserInfoResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getUserInfo, dtoType: UserInfoResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }

    static func updateUserInfo(request: UpdateUserInfoRequest, completion: @escaping(Result<UserInfoResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.updateUserInfo(request), dtoType: UserInfoResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }

    static func withdrawalUser(completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.withdrawalUser, dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
    
    static func logout(completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.logout, dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
}
