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
                SignUpData.shared.nickname = nickname
                let pageViewController = self.parent as? SignUpPageViewController
                pageViewController?.nextPage()
            case .failure(let error):
                guard let error = error as? ErrorData else { return }
                self.showToast(message: error.message)
            }
        }
    }
}

extension GetJobViewController {
    func postJobInfo(job: String) {
        let request = JobInfoRequest(job: 5, jobName: job)
        SignAPI.postJobInfo(request: request) { result in
            switch result {
            case .success:
                print("왜 두번 넘어가고 쥐룰?")
                let pageViewController = self.parent as? SignUpPageViewController
                pageViewController?.nextPage()
            case .failure(let error):
                guard let error = error as? ErrorData else { return }
                self.showToast(message: error.message)
            }
        }
    }
}
