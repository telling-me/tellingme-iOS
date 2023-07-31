//
//  CommunicationData.swift
//  tellingMe
//
//  Created by 마경미 on 31.07.23.
//

import Foundation

class CommunicationData {
    static var shared: CommunicationData? = CommunicationData()
    var threeDays: [String]
    var currentIndex: Int

    private init() {
        threeDays = []
        currentIndex = 0
    }
    
    static func clearInstance() {
        shared = nil
    }
}
