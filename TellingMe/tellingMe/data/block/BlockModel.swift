//
//  BlockModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 1/23/24.
//

import Foundation

import RealmSwift

final class BlockModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var storyId: Int
    @Persisted var userId: String
    
    convenience init(storyId: Int, userId: String) {
        self.init()
        self.storyId = storyId
        self.userId = userId
    }
}
