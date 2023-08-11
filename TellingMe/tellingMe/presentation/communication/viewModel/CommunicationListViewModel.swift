//
//  CommunicationDetailViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 28.07.23.
//

import Foundation
import RxSwift

class CommunicationListViewModel {
    var sortList: [String] = ["인기순","관련순","최신순"]
    var communicationList: [Content] = []
    
    var selectedAnswerId = BehaviorSubject<Int>(value: 0)
    
    func setAnswerId(_ answerId: Int) {
        selectedAnswerId.onNext(answerId)
    }
}
