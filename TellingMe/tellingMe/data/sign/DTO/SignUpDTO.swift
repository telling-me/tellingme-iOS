//
//  SignUpDTO.swift
//  tellingMe
//
//  Created by 마경미 on 08.04.23.
//

import Foundation

class SignUpRequest: Codable {
    static let shared = SignUpRequest()
    var allowNotification: Bool
    var nickname: String
    var purpose: String
    var job: Int
    var gender: String?
    var birthData: String?
    var mbti: String?

    private init() {
        allowNotification = false
        nickname = ""
        purpose = ""
        job = 0
    }

    func makeBirthData(year: String?, month: String?, day: String?) {
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

        birthData = resultString
    }
}

struct SignUpResponse: Codable {
    let statusCode: Int
}
