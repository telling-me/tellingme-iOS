//
//  AnswerListViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation

class AnswerListViewModel {
    var answerList: [AnswerListResponse] = []
    var answerCount = 0
    var year = Date().yearFormat()
    var month = Date().monthFormat()

    var currentTag = 0
    var yearArray: [String] = []
    var monthArray = Array(1...12).map { String($0) }
    let standardYear = 2023

    init() {
        let today = Date()
        if let todayYear = Int(today.yearFormat()) {
            yearArray = Array(standardYear...standardYear+50).map { String($0) }
        }
    }

    func getQueryDate() -> String {
        var str = "\(year)/"
        guard let temp = Int(month) else { return ""}
        if temp < 10 {
            str += "0"+self.month
        } else {
            str += self.month
        }
        return str
    }
}
