//
//  PageAPI.swift
//  tellingMe
//
//  Created by 마경미 on 13.04.23.
//

import Foundation

extension GetNameViewController {
    func checkNickname(nickname: String) {
        let request = CheckNicknameRequest(nickname: nickname)
        SignAPI.checkNickname(request: request) { result in
            switch result {
            case .success(_):
                let pageViewController = self.parent as? SignUpPageViewController
                pageViewController?.nextPageWithIndex(index: 1)
                SignUpData.shared.nickname = nickname
            case .failure(let error):
                self.setWarning()
                print("error야", error)
            }
        }
    }
}
