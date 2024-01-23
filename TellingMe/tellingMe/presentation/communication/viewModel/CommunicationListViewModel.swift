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
    // 페이지 3개중 Index
    var index = 0
    // 스크롤이 top인지
    var isTop = true
    // 페이지의 질문
    var question: QuestionListResponse = QuestionListResponse.defaultQuestion
    let size = 20 // 데이터를 가져오는 크기
    var isFetchingData = false // 데이터 가져오는 중인지 여부를 나타내는 플래그
    var isLast = false
    let sortList: [String] = ["인기순", "관련순", "최신순"]
    var currentSort: String = CommunicationData.shared.currentSortValue
//    var communicationList: [Content] = []
    let answerSuccessSubject = PublishSubject<IndexPath>()
    let communicationInitialListSubject = PublishSubject<CommunicationListResponse>()
    let communciationListSubject = PublishSubject<CommunicationListResponse>()
//    // 좋아요 누른 cell의 indexpath를 저장하기 위한 subject
//    var selectedLikeCellIndex = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
    // 선택된 cell의 indexpath와 answerId
    var selectedAnswerId = BehaviorSubject<Int>(value: 0)
    let showToastSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()

    func setInitialViewModel() {
        isTop = true
        currentSort = CommunicationData.shared.currentSortValue
        isFetchingData = false
        isLast = false
    }

    func setAnswerId(_ answerId: Int) {
        selectedAnswerId.onNext(answerId)
    }

    func postLike(answerId: Int) {
        let request = LikeRequest(answerId: answerId)
        LikeAPI.postLike(request: request)
            .subscribe(onNext: { response in
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

    func fetchAnswerData(answerId: Int, indexPath: IndexPath) {
        AnswerAPI.getAnswerWithId(query: answerId)
            .subscribe(onNext: { [weak self] response in
                self?.answerSuccessSubject.onNext(indexPath)
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

    func getIntialCommunicationList() {
        guard let date = question.date.intArraytoDate() else {
            return
        }

        isLast = false
        CommunicationData.shared.currentPage = 0
        CommunicationData.shared.communicationList[self.index] = []

        CommunicationAPI.getCommunicationList(date: date, page: CommunicationData.shared.currentPage, size: size, sort: CommunicationData.shared.currentSortValue)
            .subscribe(onNext: { [weak self] response in
                if response.last {
                    self?.isLast = true
                }
                CommunicationData.shared.setCommunicatonList(index: self?.index ?? 0, contentList: response.content)
//                self?.communciationListSubject.onNext(response)
                self?.communicationInitialListSubject.onNext(response)
            }, onError: { [weak self] error in
                if case APIError.errorData(let errorData) = error {
                    self?.showToastSubject.onNext(errorData.message)
                } else if case APIError.tokenNotFound = error {
                    self?.showToastSubject.onNext("login으로 push할게요")
                } else {
                    self?.showToastSubject.onNext("An error occurred")
                }
                CommunicationData.shared.setCommunicatonList(index: self?.index ?? 0, contentList: [])
            }).disposed(by: disposeBag)
    }

    func getCommunicationList() {
//        isFetchingData = true
        guard let date = question.date.intArraytoDate() else {
            return
        }
        if isLast {
            return
        }
        CommunicationData.shared.currentPage += 1
        CommunicationAPI.getCommunicationList(date: date, page: CommunicationData.shared.currentPage, size: size, sort: CommunicationData.shared.currentSortValue)
            .subscribe(onNext: { [weak self] response in
                CommunicationData.shared.setCommunicatonList(index: self?.index ?? 0, contentList: response.content)
                if response.last {
                    self?.isLast = true
                }
                self?.isFetchingData = false
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
    
    func reloadForBlockedStory() {
        CommunicationData.shared.removeBlockedStory(index: self.index)
    }
}
