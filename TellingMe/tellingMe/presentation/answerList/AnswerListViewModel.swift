//
//  AnswerListViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation

class AnswerListViewModel {
    var answerList: [AnswerListResponse]? = nil
    var answerCount = 0
    var year = Date().yearFormat()
    var month = Date().monthFormat()

    var yearArray = [2023]
    var monthArray = Array(1...13)
    let standardYear = 2023

    init() {
        let today = Date()
        if let todayYear = Int(today.yearFormat()) {
            yearArray = Array(standardYear...todayYear)
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
