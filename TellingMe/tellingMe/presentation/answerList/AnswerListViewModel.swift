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
}
