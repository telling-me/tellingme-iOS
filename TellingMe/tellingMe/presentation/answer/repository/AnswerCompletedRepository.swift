//
//  AnswerCompletedRepository.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import Foundation

extension AnswerCompletedViewController {
    func getQuestion() {
        QuestionAPI.getTodayQuestion { result in
            switch result {
            case .success(let response):
                self.mainQuestionLabel.text = response?.title
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
    
    func getAnswer() {
        AnswerAPI.getTodayAnswer { result in
            switch result {
            case .success(let response):
                self.answerTextView.text = response?.content
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
        guard let answerId = viewModel.answerId else { return }
        let request = DeleteAnswerRequest(answerId: answerId)
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
