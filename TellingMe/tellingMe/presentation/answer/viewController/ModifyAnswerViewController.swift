//
//  ModifyAnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import UIKit

class ModifyAnswerViewController: AnswerViewController {
    
    @IBOutlet weak var textLimitsLabel: UILabel!
    
    private var typeLimits: Int = 300
    
    override func viewDidLoad() {
        getQuestion()
        getAnswer()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch IAPManager.getHasUserPurchased() {
        case true:
            self.typeLimits = 500
            self.textLimitsLabel.text = "/ \(typeLimits)"
        case false:
            self.textLimitsLabel.text = "/ \(typeLimits)"
        }
    }

    func setQuestionDate(date: String) {
        self.viewModel.questionDate = date
    }

    override func clickCancel() {
    }

    @IBAction override func clickComplete(_ sender: UIButton) {
        viewModel.modalChanged = 1
        if answerTextView.text.count > self.typeLimits {
        // 글자수 제한에 걸리면 마지막 글자를 삭제함.
            answerTextView.text.removeLast()
            countTextLabel.text = "\(self.typeLimits)"
        } else if answerTextView.text.count <= 3 {
            self.showToast(message: "4글자 이상 작성해주세요")
            answerTextView.resignFirstResponder()
        } else {
            self.showModal(id: "modalModifyAnswer")
        }
    }

    override func clickOk() {
        if viewModel.modalChanged == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.modifyAnswer()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
