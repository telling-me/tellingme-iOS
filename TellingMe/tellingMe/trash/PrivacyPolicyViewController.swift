////
////  PrivacyPolicyViewController.swift
////  tellingMe
////
////  Created by 마경미 on 02.06.23.
////
//
//import UIKit
//
//class PrivacyPolicyViewController: SettingViewController {
//    var tag: Int = 0
//    @IBOutlet weak var textView: UITextView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if tag == 0 {
//            headerView.setTitle(title: "서비스 이용 약관")
//            readText(fileName: "TermofUse")
//        } else {
//            headerView.setTitle(title: "개인정보 처리방침")
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
//}
