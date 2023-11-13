//
//  PremiumModel.swift
//  tellingMe
//
//  Created by 마경미 on 16.10.23.
//

import Foundation
import UIKit

enum Premium {
    case oneMonth
    case year
    
//    var buttonImage: UIImage? {
//        switch self {
//        case .oneMonth:
//            return ImageLiterals.OneMonthPlusButton
//        case .year:
//            return ImageLiterals.YearPlusButton
//        }
//    }
    
    var index: Int {
        switch self {
        case .oneMonth:
            return 0
        case .year:
            return 1
        }
    }
}
