//
//  MyInfoViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import Foundation

class MyInfoViewModel {
    var currentTag: Int? = nil
    var nickname: String = ""
    var purpose: [Int] = []
    var job: Int = 0
    var jobInfo: String? = nil
    var gender: String? = nil
    var year: String? = nil
    var month: String = ""
    var day: String = ""
    var mbti: String? = nil

    let mbtis: [String] = ["ENFJ", "ENFP", "ENTJ", "ENTP", "ESFJ", "ESFP", "ESTJ", "ESTP", "INFJ", "INFP", "INTJ", "INTP", "ISFJ", "ISFP", "ESTJ", "ESTP"]
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
        nickname = data.nickname
        purpose = data.purpose.stringToInt()
        job = data.job
        jobInfo = data.jobInfo
        if let gender = data.gender {
            self.gender = gender
        }
        if let date = data.birthDate {
            self.year = "\(date[0])"
            self.month = "\(date[1])"
            self.day = "\(date[2])"
        }
        mbti = data.mbti
    }

    func makeBirthData() -> String? {
        guard let year = self.year else { return nil}
        var resultString = ""
        resultString += year
        resultString += "-"

        if self.month.count == 1 {
            resultString += "0\(self.month)"
        } else {
            resultString += self.month
        }
        resultString += "-"

        if self.day.count == 1 {
            resultString += "0\(self.day)"
        } else {
            resultString += self.day
        }
        return resultString
    }
}
