//
//  MyInfoRepository.swift
//  tellingMe
//
//  Created by 마경미 on 31.05.23.
//

import Foundation

extension MyInfoViewController {
    func getUserInfo() {
        UserAPI.getUserInfo { result in
            switch result {
            case .success(let response):
                self.viewModel.setProperties(data: response!)
                self.setInitLayout()
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }

    func updateUserInfo() {
        let request = UpdateUserInfoRequest(birthDate: viewModel.year, gender: viewModel.gender, job: viewModel.job, jobInfo: viewModel.jobInfo, mbti: viewModel.mbti, nickname: viewModel.nickname, purpose: viewModel.purpose.intArraytoString())
        UserAPI.updateUserInfo(request: request) { result in
            switch result {
            case .success(let response):
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }

    func checkJobInfo(job: String, completion: @escaping (Bool) -> Void) {
        let request = JobInfoRequest(job: 5, jobName: job)
        LoginAPI.postJobInfo(request: request) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                switch error {
                case let .errorData(errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게요")
                default:
                    break
                }
                completion(false)
            }
        }
    }

    func checkNickname(nickname: String, completion: @escaping (Bool) -> Void) {
        let request = CheckNicknameRequest(nickname: nickname)
        LoginAPI.checkNickname(request: request) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                switch error {
                case let .errorData(errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("login으로 push할게요")
                default:
                    break
                }
                completion(false)
            }
        }
    }
}
