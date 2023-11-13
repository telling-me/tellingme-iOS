//
//  TellingMePlusAPI.swift
//  tellingMe
//
//  Created by 마경미 on 14.11.23.
//

import Foundation

import Moya
import RxMoya
import RxSwift

enum TellingMePlusAPITarget {
    case postVerifyReceipt(VerifyReceiptRequest)
}

extension TellingMePlusAPITarget: TargetType {
    var path: String {
        switch self {
        case .postVerifyReceipt:
            return "api/order/purchase"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postVerifyReceipt:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postVerifyReceipt(let body):
            return .requestJSONEncodable(body)
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

struct TellingMePlusAPI: Networkable {
    typealias Target = TellingMePlusAPITarget

    static func postVerifyReceipt(request: VerifyReceiptRequest) -> Observable<VerifyReceiptResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .postVerifyReceipt(request))
        } catch  {
            print("Error getting Authroized Provider.")
            return Observable.error(APIError.tokenNotFound)
        }
    }
}
