//
//  SecureModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/10/16.
//

import Foundation

enum LockStatus {
    case intact
    case wrong
    case correct
    
    var intValue: Int {
        switch self {
        case .intact:
            return 0
        case .wrong:
            return 1
        case .correct:
            return 2
        }
    }
}

enum LockPermissionStatus {
    case unlocked
    case withPassword
    case withBiometry
}

enum SecurityModeAuthorizedStatus {
    case unable
    case disabled
    case enabled
}

enum PasswordSettingStatus {
    case none
    case passwordNotSet
    case passwordSetButToBeRemoved
    case passwordSetToggleOff
    case passwordCanBeChanged
}

enum BiometricSettingStatus {
    case none
    case biometryNotAvailable
    case passwordNotSet
    case passwordSetWithNoBiometry
    case passwordSetWithBiometry
}

/// 비밀번호가 입력이 되었는지 확인 하는 모델
/// - isAdded: 1 일 때는 비밀번호가 입력이 된 상황
/// - isAdded: 0 일 때는 비밀번호가 비어있는 상황
struct PasswordCircleModel {
    var isAdded: Int
}
