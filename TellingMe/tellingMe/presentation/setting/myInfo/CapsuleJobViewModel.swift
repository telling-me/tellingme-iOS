//
//  JobViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import Foundation
import UIKit

class CapsuleJobViewModel {
    let jobs: [String] = ["고등학생", "대학(원)생", "취업준비생", "직장인", "주부", "기타"]
    var selecteItem: Int? = nil
    let jobsCount: Int?
    var keyboardSize: CGSize? = nil

    init() {
        jobsCount = jobs.count
    }
}
