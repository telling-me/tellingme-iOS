//
//  CommunicationDetailRepository.swift
//  tellingMe
//
//  Created by 마경미 on 30.07.23.
//

import Foundation

extension CommunicationListViewController {
//    func getCommunicationList(date: [Int], completion: @escaping () -> Void) {
//        guard let date = date.intArraytoDate() else {
//            self.showToast(message: "날짜를 불러오지 못 했습니다.")
//            return
//        }
//        CommunicationAPI.getCommunicationList(date: date, page: 0, size: 10, sort: "최신순") { result in
//            switch result {
//            case .success(let response):
//                self.viewModel.communicationList = response!.content
//            case .failure(let error):
//                switch error {
//                case let .errorData(errorData):
//                    self.showToast(message: errorData.message)
//                case .tokenNotFound:
//                    print("login으로 push할게요")
//                default:
//                    print(error.localizedDescription)
//                }
//            }
//            completion()
//        }
//    }

//    func postLike(answerId: Int, completion: @escaping (Bool) -> Void) {
//        let request = LikeRequest(answerId: answerId)
//        LikeAPI.postLike(request: request) { result in
//            switch result {
//            case .success:
//               completion(true)
//            case .failure(let error):
//                switch error {
//                case let .errorData(errorData):
//                    self.showToast(message: errorData.message)
//                case .tokenNotFound:
//                    print("login으로 push할게요")
//                default:
//                    print(error)
//                }
//                completion(false)
//            }
//        }
//    }
}
