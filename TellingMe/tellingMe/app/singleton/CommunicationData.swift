//
//  CommunicationData.swift
//  tellingMe
//
//  Created by 마경미 on 31.07.23.
//

import Foundation

enum Sorting: String {
    case recent = "최신순"
    case popular = "공감순"
    case related = "관련순"
}

class CommunicationData {
    static var shared: CommunicationData = CommunicationData()
    var sortingList: [Sorting] = [.recent, .related, .popular]
    var threeDays: [QuestionListResponse] = []

    // api page를 위한
    var currentPage: Int = 0
    var communicationList: [[Content]] = [[], [], []]
    // 3일치 질문 중에 index
    var currentIndex: Int = 0
    var currentSort: Int = 0
    var currentSortValue: String {
        get {
            return sortingList[currentSort].rawValue
        }
    }

    func setCommunicatonList(index: Int, contentList: [Content]) {
        communicationList[index] += contentList
    }

    func toggleLike(_ index: Int) {
        if communicationList[currentIndex][index].isLiked {
            communicationList[currentIndex][index].isLiked = false
            communicationList[currentIndex][index].likeCount -= 1
        } else {
            communicationList[currentIndex][index].isLiked = true
            communicationList[currentIndex][index].likeCount += 1
        }
    }
}
