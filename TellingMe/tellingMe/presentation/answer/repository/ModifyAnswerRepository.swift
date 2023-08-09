//
//  ModifyAnswerRepository.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import Foundation
import UIKit

extension ModifyAnswerViewController {
    func getAnswer() {
        guard let date = viewModel.questionDate else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
        AnswerAPI.getAnswerWithDate(query: date) { result in
            switch result {
            case .success(let response):
                self.answerTextView.text = response?.content
                self.countTextLabel.text = "\(String(describing: response!.content.count))"
                self.emotionImageView.image = UIImage(named: self.viewModel.emotions[response!.emotion - 1].image)
                self.emotionLabel.text = self.viewModel.emotions[response!.emotion - 1].text
                self.publicSwitch.isOn = response!.isPublic
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
        let request = UpdateAnswerRequest(date: date, content: self.answerTextView.text, isPublic: publicSwitch.isOn)
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
