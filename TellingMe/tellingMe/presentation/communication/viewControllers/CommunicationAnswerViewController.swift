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
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.responseSubject
            .subscribe(onNext: { [weak self] response in
                self?.answerView.setTextWithNoChange(text: response.content)
                self?.likeButton.isSelected = response.isLiked
            }).disposed(by: disposeBag)
        viewModel.answerIdSubject
            .subscribe(onNext: { [weak self] data in
                self?.viewModel.answerId = data.answerId
                self?.questionView.setQuestion(data: data.question)
                self?.viewModel.fetchAnswerData()
            }).disposed(by: disposeBag)
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
            }).disposed(by: disposeBag)
    }

    func showReportView() {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "reportViewController") as? ReportViewController else {
            return
        }
        viewController.viewModel.answerId = viewModel.answerId
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
