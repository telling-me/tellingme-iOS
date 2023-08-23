//
//  MyPageDTO.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import Foundation

/**
 "2023-08-14" 형태로 날짜를 String 으로 변환한 Mypage 에 대한 Request 모델입니다.
 */
struct MypageRequest: Codable {
    let date: String
}

/**
 MyPage API 에 대한 Response 모델입니다.
 1. 닉네임
 2. 프로필 이미지 Url
 3. 연속 답변일
 4. 프리미엄 모드 유무
 5. 푸피 알림 허용 상태
 */
struct MyPageResponse: Codable {
    let nickname: String
    let profileUrl: String
    let answerRecord: Int
    let isPremium: Int
    let allowNotification: Bool
}
