//
//  NotificationDTO.swift
//  tellingMe
//
//  Created by 마경미 on 31.05.23.
//

import Foundation

struct AllowedNotificationRequest: Codable {
    let notificationStatus: Bool
}

struct AllowedNotificationResponse: Codable {
    let allowNotification: Bool
}
