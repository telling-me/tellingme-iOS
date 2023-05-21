//
//  AnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 01.05.23.
//

import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var subQuestionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!

    @IBOutlet weak var bottomLayout: NSLayoutConstraint!

    override func viewDidAppear(_ animated: Bool) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "emotion") as? EmotionViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        vc.delegate = self
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.tabBar.isHidden = true
//            tabBarController.removeShadowView()
        }
        self.present(vc, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getQuestion()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        // 키보드 높이 계산
        let keyboardHeight = keyboardFrame.size.height
        bottomLayout.constant = keyboardHeight - view.safeAreaInsets.bottom
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func clickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickComplete(_ sender: UIButton) {
        self.postAnswer()
    }
    
    @IBAction func presentEotionView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "emotion") as? EmotionViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.tabBar.isHidden = true
//            tabBarController.removeShadowView()
        }
        self.present(vc, animated: false)
    }
}

extension AnswerViewController: EmotionDelegate {
    func emotionViewCancel() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AnswerViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let font = textView.font else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5

        let attributedText = NSMutableAttributedString(string: answerTextView.text)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        attributedText.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))

        answerTextView.attributedText = attributedText
    }
}
