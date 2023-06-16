//
//  SettingRepository.swift
//  tellingMe
//
//  Created by 마경미 on 02.06.23.
//

import Foundation
import UIKit

extension WithdrawalViewController {
    func withDrawalUser() {
        LoginAPI.withdrawalUser { result in
            switch result {
            case .success:
                KeychainManager.shared.deleteAll()
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                guard let vc = storyboard.instantiateViewController(identifier: "login") as? LoginViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("토큰 업슴")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension SettingTableViewController {
    func getisAllowedNotification() {
        UserAPI.getisAllowedNotification { result in
            switch result {
            case .success(let response):
                self.pushSwitch.isOn = response!.allowNotification
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    fatalError("토큰이 없습니다")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }

    func postisAllowedNotification() {
        UserAPI.postisAllowedNotification { result in
            switch result {
            case .success(let response):
                self.pushSwitch.isOn = response!.allowNotification
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    fatalError("토큰이 없습니다")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }

    func signout() {
        LoginAPI.logout { result in
            switch result {
            case .success:
                KeychainManager.shared.deleteAll()
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                guard let vc = storyboard.instantiateViewController(identifier: "login") as? LoginViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                switch error {
                case .errorData(let errorData):
                    self.showToast(message: errorData.message)
                case .tokenNotFound:
                    print("토큰 업슴")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }
}
