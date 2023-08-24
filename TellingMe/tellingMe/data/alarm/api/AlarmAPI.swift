//
//  AlarmAPI.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import Foundation

import Moya
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
    
    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}

struct AlarmNotificationAPI: Networkable {
    typealias Target = AlarmAPITarget
    
    static func getAllAlarmNoticeWithClosure(completion: @escaping (Result<AlarmNotificationResponse?,APIError>) -> Void) {
        do {
            try makeAuthorizedProvider().request(.getAllAlarmNotice, dtoType: AlarmNotificationResponse.self, completion: completion)
        } catch APIError.tokenNotFound {
            completion(.failure(APIError.tokenNotFound))
        } catch APIError.errorData(let error) {
            completion(.failure(APIError.errorData(error)))
        } catch {
            completion(.failure(APIError.other(error)))
        }
    }
    
    static func getAllAlarmNotice() -> Observable<[AlarmNotificationResponse]> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.rx.request(.getAllAlarmNotice)
                .retry(3)
                .asObservable()
                .map {
                    try JSONDecoder().decode([AlarmNotificationResponse].self, from: $0.data)
                }
//                    print("Decoding From 'AlarmNotificationResponse' Failed")
        } catch {
            print("Alarm Error 01")
            return Observable.error(APIError.tokenNotFound)
        }
    }
    
    static func getAlarmSummary() -> Observable<AlarmSummaryResponse> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.rx.request(.getAlarmSummary)
                .retry(3)
                .asObservable()
                .map {
                    try JSONDecoder().decode(AlarmSummaryResponse.self, from: $0.data)
                }
        } catch {
            print("Alarm Error 02")
            return Observable.error(APIError.tokenNotFound)
        }
    }
    
    static func postAllAlarmAsRead() -> Single<Response> {
        do {
            print("apapap")
            let provider = try makeAuthorizedProvider()
            print("apap")
            return provider.rx.request(.postAllAlarmAsRead)
                .retry(3)
        } catch {
            print("Alarm Error 03")
            return Single.error(APIError.tokenNotFound)
        }
    }
    
    static func postSingleAlarmAsRead(selectedId: Int) -> Single<Response> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.rx.request(.postSingleAlarmAsRead(.init(noticeId: selectedId)))
                .retry(3)
        } catch {
            print("Alarm Error 04")
            return Single.error(APIError.tokenNotFound)
        }
    }
    
    static func deleteSingleAlarm(selectedId: Int) -> Single<Response> {
        do {
            let provider = try makeAuthorizedProvider()
            return provider.rx.request(.deleteSingleAlarm(.init(noticeId: selectedId)))
                .retry(3)
        } catch {
            print("Alarm Error 05")
            return Single.error(APIError.tokenNotFound)
        }
    }
}
