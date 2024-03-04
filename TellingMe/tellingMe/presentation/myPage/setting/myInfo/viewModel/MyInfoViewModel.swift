//
//  MyInfoViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import Foundation

class MyInfoViewModel {
    var currentTag: Int? = nil
    var originalNickname: String = ""
    var nickname: String = ""
    var purpose: [Int] = []
    var job: Int = 0
    var jobInfo: String? = nil
    var gender: String? = nil
    var year: String? = nil
    var mbti: String? = nil

    let mbtis: [String] = ["ENFJ", "ENFP", "ENTJ", "ENTP", "ESFJ", "ESFP", "ESTJ", "ESTP", "INFJ", "INFP", "INTJ", "INTP", "ISFJ", "ISFP", "ISTJ", "ISTP"]
    var yearArray: [String]?
    let monthArray = Array(1...12).map { String($0) }
    let dayArray = Array(1...31).map { String($0) }

    init() {
        let today = Date()
        if let todayYear = Int(today.yearFormat()) {
            yearArray = Array(todayYear-50 ... todayYear).map { String($0) }
        }
    }

    func setProperties(data: UserInfoResponse) {
        originalNickname = data.nickname
        nickname = data.nickname
        purpose = data.purpose.stringToInt()
        job = data.job
        jobInfo = data.jobInfo
        if let gender = data.gender {
            self.gender = gender
        }
        if let date = data.birthDate {
            self.year = date
        }
        mbti = data.mbti
    }
}
