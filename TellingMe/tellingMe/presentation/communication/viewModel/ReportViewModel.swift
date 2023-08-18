//
//  ReportViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 09.08.23.
//

import Foundation
import RxSwift
import RxCocoa

class ReportViewModel {
    var answerId: Int = 0
    let reports = ["욕설", "음란물", "광고", "개인정보 침해", "낚시성 콘텐츠", "기타"]
    let selectedReport = BehaviorRelay<Int?>(value: nil)
    let successSubject = PublishSubject<String>()
    let showToastSubject = PublishSubject<String>()

    // 항목 선택 시 호출되는 메서드입니다.
    func selectValue(_ value: Int) {
        selectedReport.accept(value)
    }

    func postReport() {
        guard let selectedReport = self.selectedReport.value else {
            return
        }
        let request = ReportRequest(answerId: self.answerId, reason: selectedReport)
        ReportAPI.postReport(request: request) { result in
            switch result {
            case .success:
                self.successSubject.onNext("성공")
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToastSubject.onNext(errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게요")
                default:
                    print(error)
                }
            }
        }
    }
}
