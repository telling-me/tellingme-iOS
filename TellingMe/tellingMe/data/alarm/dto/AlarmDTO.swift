//
//  AlarmDTO.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import Foundation

/**
 특정 알림 Id 를 통신하기 위한 Request 모델입니다.
 1. 특정 알림 삭제
 2. 특정 알림 읽음 처리
 */
struct AlarmNotificationIdRequest: Codable {
    let noticeId: Int
}

/**
 Question Data 를 String 으로 된 Date 로 통신하기 위한 Request 모델입니다.
 */
struct AlarmFetchDataWithDateRequest: Codable {
    let date: String
}

/**
 알림 전체 API 의 Response 모델입니다.
 - 알림창을 열었을 때 Response 를 받습니다.
 */
struct AlarmNotificationResponse: Codable {
    let noticeId: Int
    let title: String?
    let content: String
    let isRead: Bool
    let createdAt: [Int]
    let link: String?
    let isInternal: Bool
    let answerId: Int?
    let date: [Int]?
}

/**
 알림을 누르면 상세 답변 화면을 열기 위한 모델입니다. 수정이 필요합니다.
 */
struct AlarmDetailAnswerModel: Codable {
    let date: [Int]
    let title: String
    let phrase: String
}

/**
 알림벨 아이콘에 읽지 않은 알림이 있는지 확인하고, Notification Dot 을 표시할지를 결정합니다.
 */
struct AlarmSummaryResponse: Codable {
    let status: Bool
}

/**
 알림에서 개별 알림을 누르면 넘어가는 상세 답변창의 모델입니다.
 */
struct AnswerForAlarmModel {
    let emotion: Int
    let question: String
    let subQuestion: String
    let publshedDate: String
}

struct ContentForAlarmModel {
    let contentText: String
    let likeCount: Int
}

/**
 AnswerForAlarmModel 와 ContentForAlarmModel 를 합친 모델입니다.
 */
struct DetailAnswerForEachNotceModel {
    let withContent: ContentForAlarmModel
    let withQuestion: AnswerForAlarmModel
    
    static let defaultValue = DetailAnswerForEachNotceModel(withContent: .init(contentText: "", likeCount: 0), withQuestion: .init(emotion: 0, question: "", subQuestion: "", publshedDate: ""))
}
