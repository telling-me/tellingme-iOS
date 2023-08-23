////
////  CustomFont.swift
////  tellingMe
////
////  Created by KYUBO A. SHIM on 2023/08/23.
////
//
//import Foundation
//
//enum AppleSDGothicNeoType: String {
//
//    case regular = "NanumSquareRoundOTFR"
//    case bold = "NanumSquareRoundOTFB"
//}
//
//enum FontLevel {
//
//    // MARK: - Korean
//
//    case H3_Bold //26
//    case H3_Regular
//    case H4_Bold // 24
//    case H4_Regular //24
//
//    case H5_Bold //19
//    case H5_Regular
//    case H6_Bold // 17
//    case H6_Regular
//    case B1_Bold // 15
//    case B1_Regular
//
//    case B2_Bold // 14
//    case B2_Regular
//    case C1_Bold // 12
//    case C1_Regular //
//}
//
//extension FontLevel {
//
//    public var fontWeight: String {
//        switch self {
//        case .heading1_kor:
//            return AppleSDGothicNeoType.bold.rawValue
//        case .heading2_kor:
//            return AppleSDGothicNeoType.bold.rawValue
//        case .heading3_kor:
//            return AppleSDGothicNeoType.bold.rawValue
//        case .heading4_kor:
//            return AppleSDGothicNeoType.bold.rawValue
//        case .body1_bold_kor:
//            return AppleSDGothicNeoType.bold.rawValue
//        case .body1_regular_kor:
//            return AppleSDGothicNeoType.regular.rawValue
//        case .body2_bold_kor:
//            return AppleSDGothicNeoType.bold.rawValue
//        case .body2_regular_kor:
//            return AppleSDGothicNeoType.regular.rawValue
//        case .body3_bold_kor:
//            return AppleSDGothicNeoType.bold.rawValue
//        case .body3_regular_kor:
//            return AppleSDGothicNeoType.regular.rawValue
//        case .detail1_bold_kor:
//            return AppleSDGothicNeoType.bold.rawValue
//        case .detail1_regular_kor:
//            return AppleSDGothicNeoType.regular.rawValue
//        case .detail2_bold_kor:
//            return AppleSDGothicNeoType.bold.rawValue
//        case .detail2_regular_kor:
//            return AppleSDGothicNeoType.regular.rawValue
//        case .detail3_regular_kor:
//            return AppleSDGothicNeoType.regular.rawValue
//        }
//    }
//
//    public var fontSize: CGFloat {
//        switch self {
//        case .heading1_kor:
//            return 24
//        case .heading2_kor:
//            return 22
//        case .heading3_kor:
//            return 20
//        case .heading4_kor:
//            return 18
//        case .body1_bold_kor:
//            return 16
//        case .body1_regular_kor:
//            return 16
//        case .body2_bold_kor:
//            return 15
//        case .body2_regular_kor:
//            return 15
//        case .body3_bold_kor:
//            return 14
//        case .body3_regular_kor:
//            return 14
//        case .detail1_bold_kor:
//            return 13
//        case .detail1_regular_kor:
//            return 13
//        case .detail2_bold_kor:
//            return 12
//        case .detail2_regular_kor:
//            return 12
//        case .detail3_regular_kor:
//            return 11
//        }
//    }
//}
