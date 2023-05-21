//
//  AnswerRepository.swift
//  tellingMe
//
//  Created by 마경미 on 02.05.23.
//

import Foundation

extension AnswerViewController {
    func getQuestion() {
        QuestionAPI.getTodayQuestion { result in
            switch result {
            case .success(let response):
                self.questionLabel.text = response?.title
                self.subQuestionLabel.text = response?.phrase
                if let year = response?.date[0],
                   let month = response?.date[1],
                   let day = response?.date[2] {
                    self.dayLabel.text = "\(year)년 \(month)월 \(day)일"
                }
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
    
    func postAnswer() {
        let request = RegisterAnswerRequest(content: self.answerTextView.text, emotion: 1)
        AnswerAPI.registerAnswer(request: request) { result in
            switch result {
            case .success:
                self.showToast(message: "성공!")
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게요")
                default:
                    print(error)
                }
            }
        }
    }
}
