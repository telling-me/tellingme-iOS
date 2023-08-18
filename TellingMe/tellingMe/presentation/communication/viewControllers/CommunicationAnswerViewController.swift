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
//    weak var delegate: SendLikeDelegate?

    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(named: "Heart.fill"), for: .selected)
        button.setTitleColor(UIColor(named: "Gray7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFB", size: 12)
        button.tintColor = UIColor(named: "Gray6")
        let spacing: CGFloat = 4
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var questionView: QuestionView!
    @IBOutlet weak var headerView: BackEmotionHeaderView!
    @IBOutlet weak var answerView: AnswerTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.addSubview(likeButton)
        likeButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        
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
                if data.answer.likeCount == 0 {
                    self?.likeButton.setTitle("", for: .normal)
                } else {
                    self?.likeButton.setTitle("\(data.answer.likeCount)", for: .normal)
                }
            }).disposed(by: disposeBag)
        likeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                CommunicationData.shared.toggleLike(self?.viewModel.indexPath.row ?? 0)
                self?.likeButton.isSelected = CommunicationData.shared.communicationList[self?.viewModel.index ?? 0][self?.viewModel.indexPath.row ?? 0].isLiked
                if CommunicationData.shared.communicationList[self?.viewModel.index ?? 0][self?.viewModel.indexPath.row ?? 0].likeCount == 0 {
                    self?.likeButton.setTitle("", for: .normal)
                } else {
                    self?.likeButton.setTitle("\(CommunicationData.shared.communicationList[self?.viewModel.index ?? 0][self?.viewModel.indexPath.row ?? 0].likeCount)", for: .normal)
                }
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

    func showAlert() {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "alertViewController") as? AlertViewController else {
            return
        }
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true)
        viewController.setLabel(text: "신고가 접수되었어요!")
    }

    func showReportView() {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "reportViewController") as? ReportViewController else {
            return
        }
        viewController.delegate = self
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

extension CommunicationAnswerViewController: SendShowReportAlert {
    func reportCompleted() {
        self.showAlert()
    }
}
