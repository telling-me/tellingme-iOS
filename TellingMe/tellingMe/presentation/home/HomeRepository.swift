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
                case let .other(otherError):
                    print(otherError)
                }
            }
        }
    }
    
    func getStack() {
        
    }
}
