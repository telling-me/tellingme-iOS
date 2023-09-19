//
//  MyPageAPI.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import Foundation

import Moya
import RxMoya
import RxSwift

enum MyPageAPITarget {
    case getMyPageInformation(date: String)
}

extension MyPageAPITarget: TargetType {
    var path: String {
        switch self {
        case .getMyPageInformation:
            return "api/mypage"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPageInformation:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyPageInformation(let query):
            return .requestParameters(parameters: ["date": query], encoding: URLEncoding.queryString)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
     }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}

struct MyPageAPI: Networkable {
    typealias Target = MyPageAPITarget
    
    static func getMyPageInformation(request: MypageRequest) -> Observable<MyPageResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .getMyPageInformation(date: request.date))
        } catch let error {
            print(error)
            print("Error getting MyPage Provider.")
            return Observable.error(APIError.tokenNotFound)
        }
    }
}
