//
//  ModifyAnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import UIKit

class ModifyAnswerViewController: AnswerViewController {
    override func viewDidLoad() {
        self.emotionButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
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
