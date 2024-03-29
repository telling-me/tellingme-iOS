//
//  AnswerAPI.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation
import Moya
import RxSwift

enum AnswerAPITarget {
    case getAnswerList(month: String, year: String)
    case getAnswerWithDate(query: String)
    case getAnswerWithId(query: Int)
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
        case .getAnswerWithDate(let query):
            return .requestParameters(parameters: ["date": query], encoding: URLEncoding.queryString)
        case .getAnswerWithId(let query):
            return .requestParameters(parameters: ["answerId": query], encoding: URLEncoding.queryString)
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
        case .getAnswerWithDate:
            return "api/answer/date"
        case .getAnswerWithId:
            return "api/answer/id"
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
    typealias DateQuery = String

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
    
    static func getAnswerList(month:String, year: String) -> Observable<[AnswerListResponse]> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.listRequest(target: .getAnswerList(month: month, year: year))
        } catch {
            return Observable.error(error)
        }
    }

    static func getAnswerWithDate(query: String, completion: @escaping(Result<GetAnswerRespose?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getAnswerWithDate(query: query), dtoType: GetAnswerRespose.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
    
    // MARK: Getting Answer Data with Date
    static func getAnswerWithDate(query: DateQuery) -> Observable<GetAnswerRespose> {
        do {
            let provider =  try makeAuthorizedProvider()
            return provider.request(target: .getAnswerWithDate(query: query))
        } catch {
            print("Getting Answer Data failed")
            return Observable.error(error)
        }
    }
    
    static func getAnswerWithId(query: Int) -> Observable<GetAnswerRespose> {
        do {
            let provider =  try makeAuthorizedProvider()
            return provider.request(target: .getAnswerWithId(query: query))
        } catch {
            return Observable.error(error)
        }
    }

    static func getAnswerWithId(query: Int, completion: @escaping(Result<GetAnswerRespose?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getAnswerWithId(query: query), dtoType: GetAnswerRespose.self, completion: completion)
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
    
    static func registerAnswer(request: RegisterAnswerRequest) -> Observable<Void> {
        do {
            let provider =  try makeAuthorizedProvider()
            return provider.request(target: .registerAnswer(request: request))
        } catch {
            return Observable.error(error)
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
    
    // MARK: Getting Answer consecutive Day
    static func getAnswerRecord(query: DateQuery) -> Observable<AnswerRecordResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .getAnswerRecord(query: query))
        } catch {
            print("Getting Answer in row failed")
            return Observable.error(APIError.tokenNotFound)
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
