//
//  Bundle+.swift
//  tellingMe
//
//  Created by 마경미 on 16.03.23.
//

import Foundation

extension Bundle {
    var kakaoNativeAppKey: String {
        guard let file = self.path(forResource: "KeyList", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["kakaoNativeAppKey"] as? String else { fatalError("kakao Native App Key를 확인해주세요.")}
        return key
    }
}