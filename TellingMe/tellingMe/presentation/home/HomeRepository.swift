//
//  HomeRepository.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import Foundation

extension HomeViewController {
    func getQuestion() {
        QuestionAPI.getTodayQuestion { result in
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
        AnswerAPI.getTodayAnswer { result in
            switch result {
            case .success(let response):
                self.writeButton.isEnabled = false
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    if errorData.status == 4002 {
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
}
