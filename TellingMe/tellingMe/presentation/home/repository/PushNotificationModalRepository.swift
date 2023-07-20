//
//  PushNotificationModalRepository.swift
//  tellingMe
//
//  Created by 마경미 on 12.07.23.
//

import Foundation

extension PushNotificationModalViewController {
    func sendFirebaseToken() {
        guard let token = KeychainManager.shared.load(key: Keys.firebaseToken.rawValue) else {
            return
        }
        UserAPI.postFirebaseToken(request: FirebaseTokenRequest(pushToken: token)) { result in
            switch result {
            case .success:
                break
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
        self.dismiss(animated: true)
    }
}
