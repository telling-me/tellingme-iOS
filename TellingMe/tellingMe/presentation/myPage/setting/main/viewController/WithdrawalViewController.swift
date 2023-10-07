//
//  Withdrawal ViewController.swift
//  tellingMe
//
//  Created by 마경미 on 02.06.23.
//

import UIKit
import AuthenticationServices

class WithdrawalViewController: SettingViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var withdrawalButton: SecondaryTextButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkButton.setImage(UIImage(systemName: "checkmark"), for: .selected)
        withdrawalButton.isEnabled = false
        headerView.setTitle(title: "회원 탈퇴")
    }
    
    func callAppleAPI() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    @IBAction func clickAgree(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            // agree
            withdrawalButton.isEnabled = true

        } else {
            // not agree
            withdrawalButton.isEnabled = false
        }
    }

    @IBAction func clickWithdrawal(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "withdrawalModal") as? ModalViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: false)
    }
}

extension WithdrawalViewController: ModalActionDelegate {
    func clickCancel() {
    }

    func clickOk() {
        // 애플 로그인일 경우에는 authCode 받아서 진행
        if KeychainManager.shared.load(key: Keys.socialLoginType.rawValue) == "apple" {
            callAppleAPI()
        } else {
            withDrawalUser()
        }
    }
}
