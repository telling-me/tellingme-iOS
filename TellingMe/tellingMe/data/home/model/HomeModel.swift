//
//  HomeModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/23.
//

import Foundation

// MARK: - Home 에서 쓰이는 QuestionModel 입니다.

protocol QuestionModelType {
    var date: [Int] { get set }
    var title: String { get set }
    var phrase: String { get set }
    var isErrorOccured: Bool { get set }
    var errorMessage: String? { get set }
}

struct QuestionModel: QuestionModelType {
    var date: [Int]
    var title: String
    var phrase: String
    var isErrorOccured: Bool = false
    var errorMessage: String? = nil
}

struct QuestionModelWithError: QuestionModelType {
    var date: [Int] = [2023, 00, 00]
    var title: String = ""
    var phrase: String = ""
    var isErrorOccured: Bool = true
    var errorMessage: String?
}

// MARK: - Home 에서 쓰이는 PushNotificationModel 입니다.

protocol PushNotificationModelType {
    var allowNotification: Bool? { get set }
    var pushToken: String? { get set }
    var errorMessage: String? { get set }
}

struct PushNotificationModel: PushNotificationModelType {
    var allowNotification: Bool?
    var pushToken: String?
    var errorMessage: String? = nil
}

struct PushNotificationModelWithError: PushNotificationModelType {
    var allowNotification: Bool?
    var pushToken: String?
    var errorMessage: String?
}
