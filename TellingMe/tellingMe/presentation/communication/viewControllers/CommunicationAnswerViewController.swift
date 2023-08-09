//
//  CommunicationAnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 07.08.23.
//

import UIKit
import RxSwift
import RxCocoa

class CommunicationAnswerViewController: UIViewController {
    let viewModel = CommunicationAnswerViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var headerView: BackEmotionHeaderView!
    @IBOutlet weak var answerView: AnswerTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.setDataWithReport(index: 1)
        questionView.setQuestion(data: QuestionResponse(date: [2023,03,01], title: "텔링미를 사용하실 때 드는 기분은?", phrase: "하루 한번, 질문에 답변하며 나를 깨닫는 시간"))
        answerView.setTextWithNoChange(text: "hello")
        bindViewModel()
    }

    func bindViewModel() {
        likeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.toggleisLike()
            })
            .disposed(by: disposeBag)
        viewModel.isLike
            .subscribe(onNext: { [weak self] isLiked in
                self?.updateLikeButton(isLiked: isLiked)
            })
            .disposed(by: disposeBag)
        
        headerView.backButtonTapObservable
             .subscribe(onNext: { [weak self] in
                 self?.navigationController?.popViewController(animated: true)
             })
             .disposed(by: disposeBag)
        headerView.reportButtonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.showReportView()
            })
            .disposed(by: disposeBag)
    }
    
    func showReportView() {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "reportViewController") as? ReportViewController else {
            return
        }
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true, completion: nil)
    }

    func updateUI() {
        questionView.setQuestion(data: QuestionResponse(date: [22], title: "", phrase: ""))
        answerView.setTextWithNoChange(text: "")
    }

    func updateLikeButton(isLiked: Bool) {
        if isLiked {
            
        } else {

        }
    }
}
