//
//  CommunicationData.swift
//  tellingMe
//
//  Created by 마경미 on 31.07.23.
//

import Foundation

enum Sorting: String {
    case recent = "최신순"
    case popular = "인기순"
    case related = "관련순"
}

class CommunicationData {
    static var shared: CommunicationData = CommunicationData()
    var sortingList: [Sorting] = [.recent, .popular, .related]
    var threeDays: [QuestionListResponse]
    
    var communicationList: [Content] = []
    var currentIndex: Int
    var currentSort: Int = 0
    var currentSortValue: String {
        get {
            return sortingList[currentSort].rawValue
        }
    }

    private init() {
        threeDays = []
        currentIndex = 0
    }

    func setCommunicatonList(_ contentList: [Content]) {
        communicationList = contentList
    }

    func toggleLike(_ index: Int) {
        if communicationList[index].isLiked {
            communicationList[index].isLiked = false
            communicationList[index].likeCount -= 1
        } else {
            communicationList[index].isLiked = true
            communicationList[index].likeCount += 1
        }
    }
}
