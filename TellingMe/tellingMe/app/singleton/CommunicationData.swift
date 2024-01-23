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
    private let realmManager = RealmManager()
    private var blockedIds: [Int] {
        get {
            realmManager.fetchBlockedStories()
        }
    }
    var sortingList: [Sorting] = [.recent, .related, .popular]
    var threeDays: [QuestionListResponse] = []

    // api page를 위한
    var currentPage: Int = 0
    var communicationList: [[Content]] = [[], [], [], [], []]
    // 3일치 질문 중에 index
    var currentIndex: Int = 0
    var currentSort: Int = 0
    var currentSortValue: String {
        get {
            return sortingList[currentSort].rawValue
        }
    }

    func setCommunicatonList(index: Int, contentList: [Content]) {
        if blockedIds.isEmpty == false {
            let blockData = Set(blockedIds)
            print(blockData, ":blockedFirst ⚠️")
            communicationList[index] += contentList.filter { !blockData.contains($0.answerId) }
            return
        }
        communicationList[index] += contentList
    }
    
    func removeBlockedStory(index: Int) {
        let newBlockedIds = realmManager.fetchBlockedStories()
        let blockData = Set(newBlockedIds)
        communicationList[index] = communicationList[index].filter { !blockData.contains($0.answerId) }
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
