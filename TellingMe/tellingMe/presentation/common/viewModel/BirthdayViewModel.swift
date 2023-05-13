//
//  BirthdayViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import Foundation

class BirthdayViewModel {
    var year: String? = nil
    var month: String? = nil
    var day: String? = nil

    var yearArray: [Int]?
    let monthArray = Array(1...13)
    let day_Array = Array(1...32)
    
    let textArrays = ["년","월","일"]

    init() {
        let today = Date()
        if let todayYear = Int(today.yearFormat()) {
            yearArray = Array(todayYear-50 ... todayYear)
        }
    }

    func updateYear(year: String) {
        self.year = year
    }

    func updateMonth(month: String) {
        self.month = month
    }

    func updateDay(day: String) {
        self.day = day
    }
}
