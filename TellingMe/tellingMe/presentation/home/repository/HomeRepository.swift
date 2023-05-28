//
//  HomeRepository.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import Foundation

extension HomeViewController {
    func getQuestion() {
        let query = Date().getQuestionDate()
        QuestionAPI.getTodayQuestion(query: query) { result in
            switch result {
            case .success(let response):
                self.questionLabel.text = response?.title.replacingOccurrences(of: "\\n", with: "\n")
                self.subQuestionLabel.text = response?.phrase.replacingOccurrences(of: "\\n", with: "\n")
            case .failure(let error):
                switch error {
                case let .errorData(errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게요")
                default:
                    print(error)
                }
            }
        }
    }

    func getTodayAnswer() {
        let query = Date().getQuestionDate()
        AnswerAPI.getAnswer(query: query) { result in
            switch result {
            case .success:
                self.pushAnswerCompleted()
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    if errorData.status == 4003 {
                        self.pushEmotion()
                    } else {
                        self.showToast(message: errorData.message)
                    }
                case .tokenNotFound:
                    print("login으로 push할게욤")
                default:
                    print(error)
                }
            }
        }
    }

    func getAnswerRecord() {
        let query = Date().getQuestionDate()
        AnswerAPI.getAnswerRecord(query: query) { result in
            switch result {
            case .success(let response):
                if response!.count == 0 {
                    self.dayStackLabel.text = "오늘도 하루를 돌아봐요!"
                    self.dayStackLabel.setColorPart(text: "하루")
                } else {
                    self.dayStackLabel.text = "연속 \(response!.count)일째 답변 중!"
                    self.dayStackLabel.setColorPart(text: String(response!.count))
                }
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게욤")
                default:
                    print(error)
                }
            }
        }
    }
}
