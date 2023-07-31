//
//  CommunicationDetailRepository.swift
//  tellingMe
//
//  Created by 마경미 on 30.07.23.
//

import Foundation

extension CommunicationListViewController {
    func getCommunicationList(date: String) {
        CommunicationAPI.getCommunicationList(date: date, page: 0, size: 10, sort: "최신순") { result in
            switch result {
            case .success(let response):
                self.viewModel.communicationList = response!.content
                self.reloadCollectionView()
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
}
