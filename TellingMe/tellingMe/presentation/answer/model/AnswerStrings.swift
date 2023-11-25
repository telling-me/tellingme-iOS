//
//  AnswerStrings.swift
//  tellingMe
//
//  Created by 마경미 on 22.11.23.
//

import Foundation

enum AnswerStrings: String {
    case registerButton = "완료"
    case publicLabel = "공개"
    case emotionPlaceHolder = "이 글에 담긴 나의 감정은?"
    case cancelTitle = "취소"
    case confirmTitle = "확인"
    case emotionTitle = "이 글 속 나의 감정을 떠올려 봐요"
    
    var stringValue: String {
        return self.rawValue
    }
}
