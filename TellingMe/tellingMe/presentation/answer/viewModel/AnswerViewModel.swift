//
//  AnswerViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 21.05.23.
//

import Foundation

class AnswerViewModel {
    let content: String = ""
    var date: String = Date().todayFormat()
    let emotion: Int? = nil
    var questionDate: String = Date().getQuestionDate()

    init() {

    }

    func setDate(date: [Int]) {
        // 월 계산
        if date[1] < 10 {
            if date[2] < 10 {
                self.questionDate = "\(date[0])-0\(date[1])-0\(date[2])"
            } else {
                self.questionDate = "\(date[0])-0\(date[1])-\(date[2])"
            }
        } else {
            if date[2] < 10 {
                self.questionDate = "\(date[0])-\(date[1])-0\(date[2])"
            } else {
                self.questionDate = "\(date[0])-\(date[1])-\(date[2])"
            }
        }
    }
}
