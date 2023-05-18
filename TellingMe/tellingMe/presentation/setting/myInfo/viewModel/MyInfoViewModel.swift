//
//  MyInfoViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import Foundation

class MyInfoViewModel {
    var currentTag: Int? = nil
    var nickname: String? = nil
    var purpose: [Int]? = nil
    var job: Int? = nil
    var jobInfo: String? = nil
    var gender: String? = nil
    var year: String? = nil
    var month: String? = nil
    var day: String? = nil
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

    func makeBirthData(year: String?, month: String?, day: String?) -> String {
        var resultString = ""
        resultString += year ?? "1999"
        resultString += "-"

        if let tempMonth = month {
            if tempMonth.count == 1 {
                resultString += "0\(tempMonth)"
            } else {
                resultString += tempMonth
            }
        } else {
            resultString += "01"
        }
        resultString += "-"

        if let tempDay = day {
            if tempDay.count == 1 {
                resultString += "0\(tempDay)"
            } else {
                resultString += tempDay
            }
        } else {
            resultString += "01"
        }

        return resultString
    }
}
