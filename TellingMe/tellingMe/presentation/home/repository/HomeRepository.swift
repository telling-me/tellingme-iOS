//
//  HomeRepository.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import Foundation

import RxCocoa
import RxSwift

extension HomeViewController {
    func getQuestion() {
        // 함수가 호출될 때마다, 새롭게 Date 인스턴스를 만듭니다.
        let newDateString = Date().getQuestionDate()
        guard let date = newDateString else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
//
        QuestionAPI.getTodayQuestion(query: date)
            .retry(maxAttempts: 3, delay: 2)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                self.questionLabel.text = response.title.replacingOccurrences(of: "\\n", with: "\n")
                self.subQuestionLabel.text = response.phrase.replacingOccurrences(of: "\\n", with: "\n")
            }, onError: { error in
                print(error)
                
            })
            .disposed(by: disposeBag)
        
//        QuestionAPI.getTodayQuestion(query: date) { result in
//            switch result {
//            case .success(let response):
//                self.questionLabel.text = response?.title.replacingOccurrences(of: "\\n", with: "\n")
//                self.subQuestionLabel.text = response?.phrase.replacingOccurrences(of: "\\n", with: "\n")
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
    }

    func getAnswer() {
        let newDateString = Date().getQuestionDate()
        guard let date = newDateString else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
        AnswerAPI.getAnswerWithDate(query: date) { result in
            switch result {
            case .success:
                self.viewModel.isAnswerCompleted = true
                self.answerCompletedLabel.isHidden = false
            case .failure(let error):
                switch error {
                case .tokenNotFound:
                    print("login으로 push할게욤")
                default:
                    self.viewModel.isAnswerCompleted = false
                    self.answerCompletedLabel.isHidden = true
                }
            }
        }
    }

    func getAnswerRecord() {
        let newDateString = Date().getQuestionDate()
        guard let date = newDateString else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
        AnswerAPI.getAnswerRecord(query: date) { result in
            switch result {
            case .success(let response):
                if response!.count == 0 {
                    self.dayStackLabel.text = "오늘도 진정한 나를 만나봐요!"
                    self.dayStackLabel.setColorPart(text: "진정한 나", color: .Logo)
                } else {
                    self.dayStackLabel.text = "연속 \(response!.count)일째 기록 중!"
                    self.dayStackLabel.setColorPart(text: String(response!.count), color: .Logo)
                }
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게욤")
                default:
                    print(error)
                }
            }
        }
    }
}
