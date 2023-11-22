//
//  AAnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 01.11.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class AAnswerViewController: BaseViewController {
    private let backHeaderView = BackHeaderView()
    private let questionView = QuestionView()
    private let answerTextView = AnswerTextView()
    private let answerBottomView: AnswerBottomView
    private let viewModel: AnswerViewModel
    
    init(viewModel: AnswerViewModel) {
        self.viewModel = viewModel
        self.answerBottomView = AnswerBottomView(viewModel: viewModel, frame: CGRect.zero)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func bindViewModel() {
        
    }
    
    override func setStyles() {
        questionView.do {
            $0.setQuestion(data: Question(date: [], question: "", phrase: ""))
        }
    }
    
    override func setLayout() {
        view.addSubviews(backHeaderView, questionView, answerTextView,
            answerBottomView)
        
        backHeaderView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.height.equalTo(77)
        }
        
        questionView.snp.makeConstraints {
            $0.top.equalTo(backHeaderView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.width.equalTo(120)
        }
        
        answerTextView.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom).offset(36)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        answerBottomView.snp.makeConstraints {
            $0.top.equalTo(answerTextView.snp.bottom)
            $0.bottom.equalTo(view.keyboardLayoutGuide)
            $0.height.equalTo(72)
        }
    }
}
