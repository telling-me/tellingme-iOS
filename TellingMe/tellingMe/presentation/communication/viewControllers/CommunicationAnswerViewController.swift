//
//  CommunicationAnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 07.08.23.
//

import UIKit
import RxSwift
import RxCocoa

//protocol SendLikeDelegate: AnyObject {
//    func sendLikeButtonTouched()
//    func sendisLiked(indexPath: IndexPath, isLike: LikeResponse)
//}

class CommunicationAnswerViewController: UIViewController {
    let viewModel = CommunicationAnswerViewModel()
    let disposeBag = DisposeBag()
//    weak var delegate: SendLikeDelegate?

    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var headerView: BackEmotionHeaderView!
    @IBOutlet weak var answerView: AnswerTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.setDataWithReport(index: 1)
        bindViewModel()
    }
    func bindViewModel() {
        viewModel.dataSubject
            .subscribe(onNext: { [weak self] data in
                self?.viewModel.answerId = data.answer.answerId
                self?.viewModel.indexPath = data.indexPath
                self?.questionView.setQuestion(data: data.question)
                self?.answerView.setTextWithNoChange(text: data.answer.content)
                self?.likeButton.isSelected = data.answer.isLiked
            }).disposed(by: disposeBag)
        likeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                CommunicationData.shared.toggleLike(self?.viewModel.indexPath.row ?? 0)
                self?.likeButton.isSelected = CommunicationData.shared.communicationList[self?.viewModel.indexPath.row ?? 0].isLiked
                self?.likeButton.setTitle("\(CommunicationData.shared.communicationList[self?.viewModel.indexPath.row ?? 0].likeCount)", for: .normal)
                self?.viewModel.postLike()
            }).disposed(by: disposeBag)
        headerView.backButtonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
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

    func updateLikeButton(isLiked: Bool) {
        if isLiked {

        } else {

        }
    }
}
