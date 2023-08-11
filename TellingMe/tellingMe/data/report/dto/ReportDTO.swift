//
//  ReportDTO.swift
//  tellingMe
//
//  Created by 마경미 on 09.08.23.
//

import Foundation

struct ReportRequest: Codable {
    let answerId: Int
    let reason: Int
}
