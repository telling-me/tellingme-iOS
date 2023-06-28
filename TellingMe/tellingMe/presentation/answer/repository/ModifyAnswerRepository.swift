//
//  ModifyAnswerRepository.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import Foundation
import UIKit

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
        guard let date = viewModel.questionDate else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
        AnswerAPI.getAnswer(query: date) { result in
            switch result {
            case .success(let response):
                self.answerTextView.text = response?.content
                self.countTextLabel.text = "\(String(describing: response!.content.count))"
                self.emotionButton.setImage(UIImage(named: self.viewModel.emotions[response!.emotion - 1]), for: .normal)
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
        guard let date = viewModel.questionDate else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
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
