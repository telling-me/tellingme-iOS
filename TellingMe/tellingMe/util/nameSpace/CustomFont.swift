//
//  CustomFont.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import Foundation

enum NanumSquareRoundType {
    case regular
    case bold
    
    var weight: String {
        switch self {
        case .regular:
            return "NanumSquareRoundOTFR"
        case .bold:
            return "NanumSquareRoundOTFB"
        }
    }
}

enum FontLevel {

    // MARK: - Korean

    case H2_Bold // 32
    case H2_Regular
    case H3_Bold //26
    case H3_Regular
    case H4_Bold // 24
    case H4_Regular //24

    case H5_Bold //19
    case H5_Regular
    case H6_Bold // 17
    case H6_Regular
    case B1_Bold // 15
    case B1_Regular

    case B2_Bold // 14
    case B2_Regular
    case C1_Bold // 12
    case C1_Regular //
}

extension FontLevel {

    public var fontWeight: String {
        switch self {
        case .H2_Bold, .H3_Bold, .H4_Bold, .H5_Bold, .H6_Bold, .B1_Bold, .B2_Bold, .C1_Bold:
            return NanumSquareRoundType.bold.weight
        case .H2_Regular, .H3_Regular, .H4_Regular, .H5_Regular, .H6_Regular, .B1_Regular, .B2_Regular ,.C1_Regular:
            return NanumSquareRoundType.regular.weight
        }
    }

    public var fontSize: CGFloat {
        switch self {
        case .H2_Bold, .H2_Regular:
            return 32
        case .H3_Bold, .H3_Regular:
            return 26
        case .H4_Bold, .H4_Regular:
            return 24
        case .H5_Bold, .H5_Regular:
            return 19
        case .H6_Bold, .H6_Regular:
            return 17
        case .B1_Bold, .B1_Regular:
            return 15
        case .B2_Bold, .B2_Regular:
            return 14
        case .C1_Bold, .C1_Regular:
            return 12
        }
    }
}
