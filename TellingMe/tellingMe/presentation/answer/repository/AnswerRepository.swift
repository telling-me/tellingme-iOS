//
//  AnswerRepository.swift
//  tellingMe
//
//  Created by 마경미 on 02.05.23.
//

import Foundation

extension AnswerViewController {
    func getQuestion() {
        let query = Date().getQuestionDate()
        QuestionAPI.getTodayQuestion(query: query) { result in
            switch result {
            case .success(let response):
                self.questionLabel.text = response?.title.replacingOccurrences(of: "\\n", with: "\n")
                self.subQuestionLabel.text = response?.phrase.replacingOccurrences(of: "\\n", with: "\n")
                if let date = response?.date {
                    self.viewModel.setDate(date: date)
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
        guard let date = viewModel.questionDate else { return }
        let request = RegisterAnswerRequest(content: self.answerTextView.text, date: date, emotion: 1)
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
