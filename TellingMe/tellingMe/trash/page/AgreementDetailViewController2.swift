////
////  AgreementDetailViewController.swift
////  tellingMe
////
////  Created by 마경미 on 20.06.23.
////
//
//import Foundation
//import UIKit
//
//class AgreementDetailViewController: UIViewController {
//    var tag = 0
//    @IBOutlet weak var titleLabel: Body1Bold!
//    @IBOutlet weak var textView: UITextView!
//
//    override func viewDidLoad() {
//        if tag == 0 {
//            titleLabel.text = "서비스 이용약관 동의"
//            readText(fileName: "TermofUse")
//        } else {
//            titleLabel.text = "개인정보 수집 및 이용 동의"
//            readText(fileName: "PrivacyPolicy")
//        }
//    }
//
//    func readText(fileName: String) {
//        if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") {
//            do {
//                // 파일 내용을 문자열로 읽어옵니다.
//                let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
//
//                textView.text = fileContents
//            } catch {
//                self.showToast(message: "파일을 읽을 수 없습니다.")
//            }
//        } else {
//            self.showToast(message: "파일을 찾을 수 없습니다.")
//        }
//    }
//
//    func setTag(tag: Int) {
//        self.tag = tag
//    }
//
//    @IBAction func close(_ sender: UIButton) {
//        self.dismiss(animated: true)
//    }
//}
