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
        LoginAPI.checkNickname(request: request) { result in
            switch result {
            case .success:
                SignUpData.shared.nickname = nickname
                let pageViewController = self.parent as? SignUpPageViewController
                pageViewController?.nextPage()
            case .failure(let error):
                switch error {
                case let .errorData(errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게요")
                default:
                    print(error)
                }
            }
        }
    }
}

extension GetJobViewController {
    func postJobInfo(job: String) {
        let request = JobInfoRequest(job: 5, jobName: job)
        LoginAPI.postJobInfo(request: request) { result in
            switch result {
            case .success:
                let pageViewController = self.parent as? SignUpPageViewController
                pageViewController?.nextPage()
            case .failure(let error):
                switch error {
                case let .errorData(errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게요")
                default:
                    print(error)
                }
            }
        }
    }
}
