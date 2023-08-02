//
//  CommunicationRepository.swift
//  tellingMe
//
//  Created by 마경미 on 24.07.23.
//

import Foundation

extension CommunityViewController {
    func getQuestionList(completion: @escaping () -> Void) {
        guard let date = Date().getQuestionDate() else {
            self.showToast(message: "날짜를 불러올 수 없습니다.")
            return
        }
        CommunicationAPI.getQuestionList(query: date) { result in
            switch result {
            case .success(let response):
                self.viewModel.data = response!
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
            completion()
        }
    }
}
