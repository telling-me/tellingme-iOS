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
    case getisAllowedNotification
    case postisAllowedNotification
    case postFirebaseToken(FirebaseTokenRequest)
}

extension UserAPITarget: TargetType {
    var task: Task {
        switch self {
        case .updateUserInfo(let body):
            return .requestJSONEncodable(body)
        case .postFirebaseToken(let body):
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
        case .getisAllowedNotification:
            return "api/user/notification"
        case .postisAllowedNotification:
            return "api/user/update/notification"
        case .postFirebaseToken:
            return "api/user/update/pushToken"
        }
    }

    var method: Moya.Method {
        switch self {
        case .updateUserInfo:
            return .patch
        case .postisAllowedNotification, .postFirebaseToken:
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

    static func getisAllowedNotification(completion: @escaping(Result<AllowedNotificationResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getisAllowedNotification, dtoType: AllowedNotificationResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }

    static func postNotification(completion: @escaping(Result<AllowedNotificationResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.postisAllowedNotification, dtoType: AllowedNotificationResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
    
    static func postFirebaseToken(request: FirebaseTokenRequest, completion: @escaping(Result<EmptyResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.postFirebaseToken(request), dtoType: EmptyResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
}
