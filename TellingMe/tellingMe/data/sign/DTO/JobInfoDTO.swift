//
//  CheckJobNameDTO.swift
//  tellingMe
//
//  Created by 마경미 on 23.04.23.
//

import Foundation

struct JobInfoRequest: Codable {
    let job: Int
    let jobName: String
}

struct JobInfoResponse: Codable {
}
