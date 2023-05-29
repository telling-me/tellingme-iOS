//
//  AnswerCompletedRepository.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import Foundation

extension AnswerCompletedViewController {
    func getQuestion() {
        let query = Date().getQuestionDate()
        QuestionAPI.getTodayQuestion(query: query) { result in
            switch result {
            case .success(let response):
                self.mainQuestionLabel.text = response?.title.replacingOccurrences(of: "\\n", with: "\n")
                self.subQuestionLabel.text = response?.phrase.replacingOccurrences(of: "\\n", with: "\n")
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

    func getAnswer() {
        let query = Date().getQuestionDate()
        AnswerAPI.getAnswer(query: query) { result in
            switch result {
            case .success(let response):
                self.answerTextView.text = response?.content
                self.countTextLabel.text = "\(response!.content.count)"
                self.viewModel.answerId = response?.answerId
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

    func deleteAnswer() {
        let date = Date().getQuestionDate()
        let request = DeleteAnswerRequest(date: date)
        AnswerAPI.deleteAnswer(request: request) { result in
            switch result {
            case .success:
                self.showToast(message: "삭제되었습니다")
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
