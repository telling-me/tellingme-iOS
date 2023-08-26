//
//  HomeViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation

import Moya
import RxCocoa
import RxSwift

class HomeViewModel {
    let today = Date().todayFormat()
    let questionDate = Date().getQuestionDate()
    var isAnswerCompleted = false
    
    func getNewNotices(completion: @escaping (Bool) -> Void) {
        AlarmNotificationAPI.getAlarmSummary { response in
            switch response {
            case .success(let result):
                guard let newNoticeExist = result?.status else {return}
                completion(newNoticeExist)
            case .failure(let error):
                print(error)
            }
        }
    }
}
