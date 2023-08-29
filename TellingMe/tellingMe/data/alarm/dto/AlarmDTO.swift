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
}

/**
 알림벨 아이콘에 읽지 않은 알림이 있는지 확인하고, Notification Dot 을 표시할지를 결정합니다.
 */
struct AlarmSummaryResponse: Codable {
    let status: Bool
}
