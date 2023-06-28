//
//  AnswerCompletedViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import Foundation

class AnswerCompletedViewModel {
    var answerId: Int?
    let menus = ["수정", "삭제"]
    let today = Date().todayFormat()
    var questionDate: String? = nil
    var emotion: Int? = nil
    let emotions = ["Happy", "Proud","Meh", "Tired", "Sad", "Angry"]

    init () {

    }
}
