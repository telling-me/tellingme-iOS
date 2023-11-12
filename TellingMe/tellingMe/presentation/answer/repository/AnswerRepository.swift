//
//  AnswerRepository.swift
//  tellingMe
//
//  Created by 마경미 on 02.05.23.
//

import Foundation

extension AnswerViewController {
    func getQuestion() {
        guard let date = viewModel.questionDate else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
        QuestionAPI.getTodayQuestion(query: date) { result in
            switch result {
            case .success(let response):
                self.todayQuestion = Question(date: response?.date, question: response!.title, phrase: response!.phrase)
                self.spareQuestion = SpareQuestion(date: response?.date, spareQuestion: response!.spareTitle ?? "", sparePhrase: response!.sparePhrase ?? "")
                self.questionLabel.text = response?.title.replacingOccurrences(of: "\\n", with: "\n")
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

    func postAnswer() {
        guard let date = viewModel.questionDate else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
        guard let emotion = viewModel.emotion else {
            self.showToast(message: "감정을 다시 선택해주세요.")
            return
        }
        let request = RegisterAnswerRequest(content: self.answerTextView.text, date: date, emotion: emotion+1, isPublic: publicSwitch.isOn, isSpare: isSpare)
        AnswerAPI.registerAnswer(request: request) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게요")
                default:
                    self.showToast(message: error.localizedDescription)
                }
            }
        }
    }
}
