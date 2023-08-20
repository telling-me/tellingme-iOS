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

    func toggleLike(index: Int, indexPath: IndexPath) -> (Bool, Int) {
        if communicationList[index][indexPath.row].isLiked {
            communicationList[index][indexPath.row].isLiked = false
            communicationList[index][indexPath.row].likeCount -= 1
        } else {
            communicationList[index][indexPath.row].isLiked = true
            communicationList[index][indexPath.row].likeCount += 1
        }
        return (communicationList[index][indexPath.row].isLiked, communicationList[index][indexPath.row].likeCount)
    }

    func getLikeStatus(index: Int, indexPath: IndexPath) -> (Bool, Int) {
        return (communicationList[index][indexPath.row].isLiked, communicationList[index][indexPath.row].likeCount)
    }
}
