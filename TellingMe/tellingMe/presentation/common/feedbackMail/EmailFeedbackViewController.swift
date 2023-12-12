//
//  EmailFeedbackViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/10.
//

import UIKit
import MessageUI

class EmailFeedbackViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EmailFeedbackViewController: MFMailComposeViewControllerDelegate {
    func sendFeedbackMail(userOf user: String?) {
        if MFMailComposeViewController.canSendMail() {
            guard let appVersion: String = VersionManager.getCurrentVersion(), let userName = user else { return }

            let mailViewController = MFMailComposeViewController()
            let toMail = "tellingmetime@gmail.com"
            let message = """
                          
                          안녕하세요, 텔링미입니다.
                          어떤 내용을 텔링미에게 전달하고 싶으신가요? 자유롭게 작성해주시면 확인 후 답변 드리겠습니다. 감사합니다.😃
                          📱 쓰고 있는 핸드폰 기종 (예:아이폰 12):
                          
                          🧭 앱 버전: \(appVersion)
                          🧗🏻‍♀️ 닉네임: \(userName)
                          
                          ⚠️ 오류를 발견하셨을 경우 ⚠️
                          📍발견한 오류 :
                          
                          📷 오류 화면 (캡쳐 혹은 화면녹화):

                          
                          """
            mailViewController.mailComposeDelegate = self
            mailViewController.setToRecipients([toMail])
            mailViewController.setSubject("[텔링미 고객센터] 전달사항이 있어요!")
            mailViewController.setMessageBody(message, isHTML: false)
            self.present(mailViewController, animated: true)
        } else {
            guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            let alert = UIAlertController(title: "기기의 'Mail'에 먼저 로그인 해주세요.", message: "설정에서 Apple 로그인을 해주세요.", preferredStyle: .alert)
            let moveToDeviceSettingAction = UIAlertAction(title: "설정", style: .default) { _ in
                UIApplication.shared.open(settingUrl)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(moveToDeviceSettingAction)
            alert.addAction(cancelAction)
            alert.preferredAction = moveToDeviceSettingAction

            present(alert, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
