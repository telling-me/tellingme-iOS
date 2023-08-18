//
//  AnswerListViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation
import RxCocoa
import RxSwift

class AnswerListViewModel {
    var answerList: [AnswerListResponse] = []
//    var answerCount = 0
    var year = Date().yearFormat()
    var month = Date().monthFormat()
    var responseSubject = PublishSubject<[AnswerListResponse]>()

    // 카드뷰 0, 테이블 1
    var currentlistTag = 0
    // year인지 month인지
    var currentTag = 0
    var yearArray: [String] = []
    var monthArray = Array(1...12).map { String($0) }
    let standardYear = 2023

    let showToastSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()

    init() {
        let today = Date()
        if let todayYear = Int(today.yearFormat()) {
            yearArray = Array(standardYear...standardYear+50).map { String($0) }
        }
    }

    func getQueryDate() -> String {
        var str = "\(year)/"
        guard let temp = Int(month) else { return ""}
        if temp < 10 {
            str += "0"+self.month
        } else {
            str += self.month
        }
        return str
    }

    func getAnswerList() {
        AnswerAPI.getAnswerList(month: month, year: year)
            .subscribe(onNext: { [weak self] response in
                self?.answerList = response
                self?.responseSubject.onNext(response)
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
}
