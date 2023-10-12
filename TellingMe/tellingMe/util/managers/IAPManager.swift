//
//  IAPManager.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/10/12.
//

import UIKit

final class IAPManager {
    
    static func getHasUserPurchased() -> Bool {
        let userDefaults = UserDefaults.standard
        if userDefaults.string(forKey: StringLiterals.paidProductId) != nil {
            return true
        } else {
            return false
        }
    }
}
