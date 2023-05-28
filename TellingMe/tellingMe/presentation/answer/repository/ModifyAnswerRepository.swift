//
//  ModifyAnswerRepository.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import Foundation

extension ModifyAnswerViewController {
//    func getQuestion() {
//        QuestionAPI.getTodayQuestion { result in
//            switch result {
//            case .success(let response):
//                self.questionLabel.text = response?.title
//                self.subQuestionLabel.text = response?.phrase
//                if let year = response?.date[0],
//                   let month = response?.date[1],
//                   let day = response?.date[2] {
//                    self.dayLabel.text = "\(year)년 \(month)월 \(day)일"
//                }
//            case .failure(let error):
//                switch error {
//                case let .errorData(errorData):
//                    self.showToast(message: errorData.message)
//                case .tokenNotFound:
//                    print("login으로 push할게요")
//                default:
//                    print(error)
//                }
//            }
//        }
//    }
//
    func getAnswer() {
        let query = Date().getQuestionDate()
        AnswerAPI.getAnswer(query: query) { result in
            switch result {
            case .success(let response):
                self.answerTextView.text = response?.content
                self.emotionButton.isEnabled = false
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

    func modifyAnswer() {
        guard let date = viewModel.date else { return }
        let request = UpdateAnswerRequest(date: date, content: self.answerTextView.text)
        AnswerAPI.updateAnswer(request: request) { result in
            switch result {
            case .success:
                self.navigationController?.popViewController(animated: true)
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
