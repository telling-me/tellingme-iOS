//
//  DetailAnswerViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/01.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class DetailAnswerViewController: UIViewController {

    private var answerId = 0
    private var datePublished = "2023-01-01"
    private lazy var viewModel = AlarmNoticeViewModel(answerId: self.answerId, datePublished: self.datePublished)
    private var disposeBag = DisposeBag()
    
    private let customNavigationView = HeaderViewWithEmotionView()
    private let contentWithTextView = ContentWithTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension DetailAnswerViewController {
    
    private func bindViewModel() {
        viewModel.outputs.answerData
            .subscribe(onNext: { [weak self] response in
                let contentData: ContentForAlarmModel = ContentForAlarmModel(contentText: response.withContent.contentText, likeCount: response.withContent.likeCount)
                let questionData: AnswerForAlarmModel = AnswerForAlarmModel(emotion: response.withQuestion.emotion, question: response.withQuestion.question, subQuestion: response.withQuestion.subQuestion, publshedDate: response.withQuestion.publshedDate)
                self?.contentWithTextView.configure(data: contentData)
                self?.customNavigationView.configure(data: questionData)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        customNavigationView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        view.backgroundColor = .Side100
    }
    
    private func setLayout() {
        view.addSubviews(customNavigationView, contentWithTextView)
        
        customNavigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(198)
        }
        
        contentWithTextView.snp.makeConstraints {
            $0.top.equalTo(customNavigationView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension DetailAnswerViewController {
    func setData(answerId: Int, datePublished: String) {
        self.answerId = answerId
        self.datePublished = datePublished
    }
}
