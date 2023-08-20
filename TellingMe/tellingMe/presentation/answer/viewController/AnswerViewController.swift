//
//  AnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 01.05.23.
//

import UIKit

class AnswerViewController: UIViewController, ModalActionDelegate {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var subQuestionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!

    @IBOutlet weak var emotionView: UIView!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var emotionLabel: Body2Bold!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!

    @IBOutlet weak var countTextLabel: UILabel!
    @IBOutlet weak var foldView: UIView!
    @IBOutlet weak var foldViewHeight: NSLayoutConstraint!

    @IBOutlet weak var publicSwitch: UISwitch!

    let viewModel = AnswerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        getQuestion()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.dayLabel.text = viewModel.date
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if answerTextView.text.count > 300 {
        // 글자수 제한에 걸리면 마지막 글자를 삭제함.
            answerTextView.text.removeLast()
            countTextLabel.text = "\(300)"
        }
         answerTextView.resignFirstResponder()
     }

    func showEmotion() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "emotion") as? EmotionViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        vc.delegate = self
        vc.viewModel.selectedEmotion = self.viewModel.emotion
        self.present(vc, animated: false)
    }

    func showModal(id: String) {
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: id) as? ModalViewController else {
            return
        }
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: false)
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
        viewModel.modalChanged = 0
        showModal(id: "cancelAnswerModal")
    }

    @IBAction func clickComplete(_ sender: UIButton) {
        viewModel.modalChanged = 1
        if answerTextView.text.count > 300 {
        // 글자수 제한에 걸리면 마지막 글자를 삭제함.
            answerTextView.text.removeLast()
            countTextLabel.text = "\(300)"
        } else if answerTextView.text.count <= 3 {
            self.showToast(message: "4글자 이상 작성해주세요")
            answerTextView.resignFirstResponder()
        } else {
            showEmotion()
        }
    }

    @IBAction func foldView(_ sender: UIButton) {
        if foldViewHeight.constant == 0 {
            self.foldView.isHidden = false
            self.foldViewHeight.constant = 120
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            self.foldView.isHidden = true
            self.foldViewHeight.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
    }

    func clickCancel() {
    }

    // 답변 등록하기 버튼
    func clickOk() {
        if viewModel.modalChanged == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.postAnswer()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
