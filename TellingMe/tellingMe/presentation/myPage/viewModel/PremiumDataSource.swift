//
//  PremiumDataSource.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/11.
//

import Foundation

import RxDataSources

struct SectionOfPremiumInformation {
    var header: String
    var footer: String
    var items: [Item]
}

extension SectionOfPremiumInformation: SectionModelType {
    typealias Item = String
    
    init(original: SectionOfPremiumInformation, items: [String]) {
        self = original
        self.items = items
    }
}
