//
//  Question.swift
//  tellingMe
//
//  Created by 마경미 on 31.10.23.
//

import Foundation

enum QuestionType {
    case original
    case special
}

struct Question {
    let date: [Int]?
    let question: String
    let phrase: String
}

struct SpareQuestion {
    let date: [Int]?
    let spareQuestion: String
    let sparePhrase: String
}
