//
//  StringLiteral.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/01.
//

import UIKit

enum StringLiterals {
    /// UserDefaults
    static let isPushNotificationPermittedKey: String = "PushPermit"
    static let isDeviceAbnormal: String = "DeviceAbnormal"
    static let isDeviceChecked: String = "DeviceEverChecked"
    static let savedUserName: String = "SavedUserName"
    static let lastQuestionRefreshTime: String = "LastRefreshTime"
}

enum ImageLiterals {
    
    /// Tab Images
    static let TabHomeSelected: UIImage? = UIImage(named: "HomeSelected")
    static let TabHomeDeselected: UIImage? = UIImage(named: "HomeDeselected")
    static let TabMyAnswerListSelected: UIImage? = UIImage(named: "MyAnswersSelected")
    static let TabMyAnswerListDeselected: UIImage? = UIImage(named: "MyAnswersDeselected")
    static let TabMyLibrarySelected: UIImage? = UIImage(named: "LibrarySelected")
    static let TabMyLibraryDeselected: UIImage? = UIImage(named: "LibraryDeselected")
    static let TabCommunicationSelected: UIImage? = UIImage(named: "CommunicationSelected")
    static let TabCommunicationDeselected: UIImage? = UIImage(named: "CommunicationDeselected")
    
    /// Home Images
    static let HomeLogo: UIImage? = UIImage(named: "Logo")
    static let HomeNoticeAlarm: UIImage? = UIImage(named: "NoticeAlarm")
    static let HomeNoticeAlarmWithDot: UIImage? = UIImage(named: "NoticeAlarmWithDot")
    static let HomeSetting: UIImage? = UIImage(named: "Setting")
    static let HomeWriteWingPen: UIImage? = UIImage(named: "WingPen")
    static let HomeSticker: UIImage? = UIImage(named: "Shape")
    static let HomeRotatingImage: UIImage? = UIImage(named: "Shape5")
    static let HomeFloatingImage: UIImage? = UIImage(named: "AnimatingGroup")
    
    /// Pop Up Images
    static let WorkInProgress: UIImage? = UIImage(named: "WorkInProgress")
    static let PushNotificationAlarm: UIImage? = UIImage(named: "BellRinging")
}

enum UrlLiterals {
    static let termsOfUseUrl: String = "https://doana.notion.site/f42ec05972a545ce95231f8144705eae?pvs=4"
    static let privacyPolicyUrl: String = "https://doana.notion.site/7cdab221ee6d436781f930442040d556?pvs=4"
    static let faqUrl: String = "https://doana.notion.site/f7a045872c3b4b02bce5e9f6d6cfc2d8?pvs=4"
    static let questionPlant: String = "https://tally.so/r/3Nlvlp"
}

enum DeviceLiterals: CaseIterable {
    case six
    case sixPlus
    case sixS
    case sixSPlus
    case seven
    case sevenPlus
    case eight
    case eightPlus
    case seOne
    case seTwo
    case seThree
    case iPadMiniFour
    case iPadMiniFive
    case iPadMiniSix
//    case iPadMiniSeven
    
    var deviceName: String {
        switch self {
        case .six:
            return "iPhone 6"
        case .sixPlus:
            return "iPhone 6 Plus"
        case .sixS:
            return "iPhone 6s"
        case .sixSPlus:
            return "iPhone 6s Plus"
        case .seven:
            return "iPhone 7"
        case .sevenPlus:
            return "iPhone 7 Plus"
        case .eight:
            return "iPhone 8"
        case .eightPlus:
            return "iPhone 8 Plus"
        case .seOne:
            return "iPhone SE (1st generation)"
        case .seTwo:
            return "iPhone SE (2nd generation)"
        case .seThree:
            return "iPhone SE (3rd generation)"
        case .iPadMiniFour:
            return "iPad mini 4"
        case .iPadMiniFive:
            return "iPad mini (5th generation)"
        case .iPadMiniSix:
            return "iPad mini (6th generation)"
        }
    }
}

/// 정형화된 해상도 및 비율이 아니어서 따로 관리가 필요한 모델입니다.
enum DeviceSecondaryAbnormal: CaseIterable {
    case iPhoneX
    case iPhoneXS
    case iPhoneElevenPro
    
    var deviceName: String {
        switch self {
        case .iPhoneX:
            return "iPhone X"
        case .iPhoneXS:
            return "iPhone Xs"
        case .iPhoneElevenPro:
            return "iPhone 11 Pro"
        }
    }
}
