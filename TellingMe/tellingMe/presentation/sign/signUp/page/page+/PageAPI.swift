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
            case .success:
                let pageViewController = self.parent as? SignUpPageViewController
                pageViewController?.nextPageWithIndex(index: 2)
                SignUpData.shared.nickname = nickname
            case .failure(let error):
                if let error = error as? CheckNicknameErrorResponse {
                    self.setWarning()
                    self.showToast(message: error.message)
                }
            }
        }
    }
}
