//
//  ModifyAnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import UIKit

class ModifyAnswerViewController: AnswerViewController {
    override func viewDidLoad() {
        self.emotionButton.isUserInteractionEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getAnswer()
    }

    override func viewDidAppear(_ animated: Bool) {

    }

    func setQuestionDate(date: String) {
        self.viewModel.questionDate = date
    }

    override func clickCancel() {
    }

    // 답변 등록하기 버튼
    override func clickOk() {
        self.modifyAnswer()
        self.navigationController?.popViewController(animated: true)
    }
}
