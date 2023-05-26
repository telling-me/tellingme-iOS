//
//  ModifyAnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import UIKit

class ModifyAnswerViewController: AnswerViewController {
    let viewModel = ModifyAnswerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAnswer()
        self.emotionButton.isEnabled = false
    }

    override func clickCancel() {
    }

    // 답변 등록하기 버튼
    override func clickOk() {
        self.modifyAnswer()
        self.navigationController?.popViewController(animated: true)
    }
}
