//
//  CommunicationAnswerViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 07.08.23.
//

import Foundation
import RxSwift
import RxCocoa

class CommunicationAnswerViewModel {
    let answerId: Int = 0
    let questionData: String = ""
    let contentData: String = ""
    let isLike = BehaviorRelay<Bool>(value: false)
    var answerData: GetAnswerRespose? = nil

    func toggleisLike() {
        let request = LikeRequest(answerId: answerId)
        LikeAPI.postLike(request: request) { result in
            switch result {
            case .success(let resposne):
                self.isLike.accept(!self.isLike.value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAnswerData(id: Int) -> GetAnswerRespose? {
        var data: GetAnswerRespose? = nil
        AnswerAPI.getAnswerWithId(query: id) { result in
            switch result {
            case .success(let response):
                self.answerData = response
            case .failure(let error):
                switch error {
                case .errorData(let errorData): break
//                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게요")
                default:
                    print(error)
                }
            }
        }
        return data
    }
}
