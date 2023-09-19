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

    var APIURL: String {
        guard let file = self.path(forResource: "KeyList", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_URL"] as? String else { fatalError("API URL을 확인해주세요.")}
        return key
    }
    
    var metaShareKey: String {
        guard let file = self.path(forResource: "KeyList", ofType: "plist") else {return ""}
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["metaKey"] as? String else { fatalError("Meta Key 를 확인해주세요.") }
        return key
    }
}
