//
//  AnalyzeManager.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/10/06.
//

import UIKit

import FirebaseAnalytics

final class GAManager {
    static let shared = GAManager()
    
    private init() {}
    
    enum EventType {
        case screen(screenName: String)
        
        var eventName: String {
            switch self {
            case .screen:
                return "screen"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .screen(let screenName):
                ["screen": screenName]
            }
        }
    }
    
    func logEvent(eventType: EventType) {
        Analytics.logEvent(eventType.eventName, parameters: eventType.parameters)
    }
    
}
