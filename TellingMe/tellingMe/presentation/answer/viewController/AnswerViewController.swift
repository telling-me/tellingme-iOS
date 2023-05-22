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

    @IBOutlet weak var emotionButton: UIButton!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!

    @IBOutlet weak var foldView: UIView!
    @IBOutlet weak var foldViewHeight: NSLayoutConstraint!
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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

    @objc func keyboardWillHide(_ notification: Notification) {
        bottomLayout.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func clickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickComplete(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "modalRegisterAnswer") as? ModalViewController else {
            return
        }
        vc.delegeate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
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

    @IBAction func foldView(_ sender: UIButton) {
        if foldViewHeight.constant == 0 {
            self.foldViewHeight.constant = 120
            self.dayLabel.isHidden = false
            self.subQuestionLabel.isHidden = false
            self.questionLabel.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.foldView.layoutIfNeeded()
            }
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            self.foldViewHeight.constant = 0
            self.questionLabel.isHidden = true
            self.subQuestionLabel.isHidden = true
            self.dayLabel.isHidden = true
            UIView.animate(withDuration: 0.3) {
                self.foldView.layoutIfNeeded()
            }
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
    }
}
