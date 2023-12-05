//
//  Emotion.swift
//  tellingMe
//
//  Created by 마경미 on 27.08.23.
//

import Foundation
import UIKit

enum Emotions: String {
    case happy = "Happy"
    case proud = "Proud"
    case meh = "Meh"
    case tired = "Tired"
    case sad = "Sad"
    case angry = "Angry"
    case excited = "Excited"
    case thrilled = "ㅆhrilled"
    case relaxed = "Relaxed"
    case lethargic = "Lethargic"
    case lonely = "Lonely"
    case complicated = "Complicated"

    var stringValue: String {
        switch self {
        case .happy:
            return "행복해요"
        case .proud:
            return "뿌듯해요"
        case .meh:
            return "그저 그래요"
        case .tired:
            return "피곤해요"
        case .sad:
            return "슬퍼요"
        case .angry:
            return "화나요"
        case .excited:
            return "설레요"
        case .thrilled:
            return "신나요"
        case .relaxed:
            return "편안해요"
        case .lethargic:
            return "무기력해요"
        case .lonely:
            return "외로워요"
        case .complicated:
            return "복잡해요"
        }
    }
//    
//    var imageValue: String {
//        switch self {
//        case .happy:
//            return "행복해요"
//        case .proud:
//            return "뿌듯해요"
//        case .meh:
//            return "그저 그래요"
//        case .tired:
//            return "피곤해요"
//        case .sad:
//            return "슬퍼요"
//        case .angry:
//            return "화나요"
//        }
//    }
//
//    var intValue: Int {
//        switch self {
//        case .happy:
//            return 0
//        case .proud:
//            return 1
//        case .meh:
//            return 2
//        case .tired:
//            return 3
//        case .sad:
//            return 4
//        case .angry:
//            return 5
//        }
//    }

    var color: UIColor {
        switch self {
        case .happy:
            return .Emotion100
        case .proud:
            return .Emotion200
        case .meh:
            return .Emotion300
        case .tired:
            return .Emotion400
        case .sad:
            return .Emotion500
        case .angry:
            return .Emotion600
        default:
            return .Black
        }
    }

    init?(stringValue: String) {
        switch stringValue {
        case "행복해요":
            self = .happy
        case "자랑스러워요":
            self = .proud
        case "별로에요":
            self = .meh
        case "피곤해요":
            self = .tired
        case "슬퍼요":
            self = .sad
        case "화나요":
            self = .angry
        default:
            return nil
        }
    }

    init?(intValue: Int) {
        switch intValue {
        case 0:
            self = .happy
        case 1:
            self = .proud
        case 2:
            self = .meh
        case 3:
            self = .tired
        case 4:
            self = .sad
        case 5:
            self = .angry
        default:
            return nil
        }
    }
    
    static func standardEmotionArray() -> [Emotions] {
        return [.happy, .proud, .meh, .tired, .sad, .angry]
    }
    
    static var premeiumEmotionArray: [Emotions] {
        return [.happy, .proud, .meh, .tired,
            .sad, .angry, .excited, .thrilled, .relaxed,
            .lethargic, .lonely, .complicated]
    }
}
