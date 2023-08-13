//
//  CommunicationDetailViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 28.07.23.
//

import Foundation
import RxSwift
import RxCocoa

class CommunicationListViewModel {
    var sortList: [String] = ["인기순", "관련순", "최신순"]
//    var communicationList: [Content] = []
    var communciationListSubject = PublishSubject<CommunicationListResponse>()
//    // 좋아요 누른 cell의 indexpath를 저장하기 위한 subject
//    var selectedLikeCellIndex = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
    // 선택된 cell의 indexpath와 answerId
    var selectedAnswerId = BehaviorSubject<Int>(value: 0)
    let showToastSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()

    func setAnswerId(_ answerId: Int) {
        selectedAnswerId.onNext(answerId)
    }

    func postLike(answerId: Int) {
        let request = LikeRequest(answerId: answerId)
        LikeAPI.postLike(request: request)
            .subscribe(onNext: { [weak self] response in
            }, onError: { [weak self] error in
                if case APIError.errorData(let errorData) = error {
                    self?.showToastSubject.onNext(errorData.message)
                } else if case APIError.tokenNotFound = error {
                    self?.showToastSubject.onNext("login으로 push할게요")
                } else {
                    self?.showToastSubject.onNext("An error occurred")
                }
            }).disposed(by: disposeBag)
    }

    func getCommunicationList(date: [Int]) {
        guard let date = date.intArraytoDate() else {
            return
        }
        CommunicationAPI.getCommunicationList(date: date, page: 0, size: 10, sort: CommunicationData.shared.currentSortValue)
            .subscribe(onNext: { [weak self] response in
                CommunicationData.shared.setCommunicatonList(response.content)
//                self?.communicationList = / response.content
                self?.communciationListSubject.onNext(response)
            }, onError: { [weak self] error in
                if case APIError.errorData(let errorData) = error {
                    self?.showToastSubject.onNext(errorData.message)
                } else if case APIError.tokenNotFound = error {
                    self?.showToastSubject.onNext("login으로 push할게요")
                } else {
                    self?.showToastSubject.onNext("An error occurred")
                }
            }).disposed(by: disposeBag)
    }

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
}
