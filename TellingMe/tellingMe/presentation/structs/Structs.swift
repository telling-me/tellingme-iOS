//
//  File.swift
//  tellingMe
//
//  Created by 마경미 on 02.04.23.
//

import Foundation

struct TeritaryBothData {
    let title: String
    let imgName: String

    init(imgName: String, title: String) {
        self.title = title
        self.imgName = imgName
    }
}

struct JobViewModel {
    let title: String
    let imgName: String
}

struct Birth {
    var year: String?
    var month: String?
    var day: String?
}
