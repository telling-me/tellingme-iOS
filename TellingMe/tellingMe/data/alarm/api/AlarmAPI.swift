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
    
    static func getAllAlarmNotice() {}
    static func getAlarmSummary() {}
    static func postAllAlarmAsRead() {}
    static func postSingleAlarmAsRead(selectedId: Int) {}
    static func deleteSingleAlarm(selectedId: Int) {}
}
