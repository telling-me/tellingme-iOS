//
//  RealmManager.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 1/23/24.
//

import Foundation

import RealmSwift

struct RealmManager {
    
    func blockStoryId(of storyId: Int, userIdOf userId: String) {
        let realm = try! Realm()
        let newBlockObject = BlockModel(storyId: storyId, userId: userId)
        try! realm.write({
            realm.add(newBlockObject)
        })
    }
    
    func fetchBlockedStories() -> [Int] {
        let realm = try! Realm()
        var blockedIds: [Int]
        blockedIds = Array(realm.objects(BlockModel.self))
            .map { $0.storyId }
        return blockedIds
    }
}

