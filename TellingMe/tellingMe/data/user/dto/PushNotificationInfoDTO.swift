//
//  PushNotificationInfoDTO.swift
//  tellingMe
//
//  Created by 마경미 on 30.08.23.
//

import Foundation

struct PushNotificationInfoRequest: Codable {
    let allowNotification: Bool
    let pushToken: String
}

struct PushNotificationInfoResponse: Codable {
    let allowNotification: Bool?
    let pushToken: String?
}
