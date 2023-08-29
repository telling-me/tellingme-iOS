//
//  AlarmAPI.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import Foundation

import Moya
import RxMoya
import RxSwift

enum AlarmAPITarget {
    case getAllAlarmNotice
    case getAlarmSummary
    case postAllAlarmAsRead
    case postSingleAlarmAsRead(AlarmNotificationIdRequest)
    case deleteSingleAlarm(AlarmNotificationIdRequest)
}

extension AlarmAPITarget: TargetType {
    var path: String {
        switch self {
        case .getAllAlarmNotice:
            return "api/notice"
        case .getAlarmSummary:
            return "api/notice/summary"
        case .postAllAlarmAsRead:
            return "api/notice/readAll"
        case .postSingleAlarmAsRead(let noticeId):
            return "api/notice/read/\(noticeId.noticeId)"
        case .deleteSingleAlarm(let noticeId):
            return "api/notice/\(noticeId.noticeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllAlarmNotice, .getAlarmSummary:
            return .get
        case .postAllAlarmAsRead, .postSingleAlarmAsRead:
            return .post
        case .deleteSingleAlarm:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAllAlarmNotice, .getAlarmSummary, .postAllAlarmAsRead, .postSingleAlarmAsRead, .deleteSingleAlarm:
            return .requestPlain
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

struct AlarmNotificationAPI: Networkable {
    typealias Target = AlarmAPITarget
        
    static func getAllAlarmNotice() -> Observable<[AlarmNotificationResponse]> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .getAllAlarmNotice)
        } catch {
            print("Alarm Error 01")
            return Observable.error(APIError.tokenNotFound)
        }
    }
    
    static func getAlarmSummary() -> Observable<AlarmSummaryResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .getAlarmSummary)
        } catch {
            print("Alarm Error 02")
            return Observable.error(APIError.tokenNotFound)
        }
    }
    
    static func getAlarmSummary(completion: @escaping (Result<AlarmSummaryResponse?, APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getAlarmSummary, dtoType: AlarmSummaryResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
    
    static func postAllAlarmAsRead() -> Observable<EmptyResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .postAllAlarmAsRead)
        } catch {
            print("Alarm Error 03")
            return Observable.error(APIError.tokenNotFound)
        }
    }
    
    static func postSingleAlarmAsRead(selectedId: Int) -> Observable<EmptyResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .postSingleAlarmAsRead(.init(noticeId: selectedId)))
        } catch {
            print("Alarm Error 04")
            return Observable.error(APIError.tokenNotFound)
        }
    }
    
    static func deleteSingleAlarm(selectedId: Int) -> Observable<EmptyResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.request(target: .deleteSingleAlarm(.init(noticeId: selectedId)))
        } catch {
            print("Alarm Error 05")
            return Observable.error(APIError.tokenNotFound)
        }
    }
}
