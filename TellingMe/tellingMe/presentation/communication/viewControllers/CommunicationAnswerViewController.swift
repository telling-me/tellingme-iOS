//
//  CommunicationAnswerViewController.swift
//  tellingMe
//
//  Created by 마경미 on 07.08.23.
//

import UIKit
import RxSwift
import RxCocoa

protocol SendCurrentLikeDelegate: AnyObject {
    func sendLike(isLike: Bool, likeCount: Int)
    func reloadToRemoveBlockStory()
}

class CommunicationAnswerViewController: UIViewController {
    
    let viewModel = CommunicationAnswerViewModel()
    var delegate: SendCurrentLikeDelegate?
    let disposeBag = DisposeBag()

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

    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.fetchAnswerData()
        self.questionView.setQuestion(data: viewModel.receivedData.question)
    }

    func bindViewModel() {
        viewModel.answerSubject
            .subscribe(onNext: { [weak self] data in
                self?.answerView.setTextWithNoChange(text: data.content)
                self?.headerView.emotionView.setText(index: data.emotion)
                self?.setLikeButton(isLiked: data.isLiked, likeCount: data.likeCount)
            }).disposed(by: disposeBag)
        likeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.toggleLikeButton()
            }).disposed(by: disposeBag)
        headerView.backButtonTapObservable
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let (isLike, likeCount) = CommunicationData.shared.getLikeStatus(index: self.viewModel.receivedData.index, indexPath: self.viewModel.receivedData.indexPath)
                self.delegate?.sendLike(isLike: isLike, likeCount: likeCount)
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        headerView.reportButtonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.showReportView()
            }).disposed(by: disposeBag)
    }

    func setLikeButton(isLiked: Bool, likeCount: Int) {
        self.likeButton.isSelected = isLiked
        if likeCount == 0 {
            likeButton.setTitle("", for: .normal)
        } else {
            likeButton.setTitle("\(likeCount)", for: .normal)
        }
    }

    func toggleLikeButton() {
        let (isLiked, likeCount) = CommunicationData.shared.toggleLike(index: self.viewModel.receivedData.index, indexPath: self.viewModel.receivedData.indexPath)
        // 좋아요 취소
        likeButton.isSelected = isLiked
        if likeCount == 0 {
            likeButton.setTitle("", for: .normal)
        } else {
            likeButton.setTitle("\(likeCount)", for: .normal)
        }
        self.viewModel.postLike()
    }

    func showAlert() {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "alertViewController") as? AlertViewController else {
            return
        }
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.delegate = self
        self.present(viewController, animated: true)
        viewController.setLabel(text: "신고가 접수되었어요!")
    }

    func showReportView() {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "reportViewController") as? ReportViewController else {
            return
        }
        viewController.delegate = self
        viewController.viewModel.answerId = viewModel.answerId
        viewController.viewModel.userId = viewModel.userId
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

extension CommunicationAnswerViewController: SendShowReportAlert, AlertActionDelegate {
    func clickOk() {
        navigationController?.popViewController(animated: true)
        delegate?.reloadToRemoveBlockStory()
    }
    
    func reportCompleted() {
        self.showAlert()
    }
}
