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
    private let viewModel = AnswerViewModel()
    private let disposeBag = DisposeBag()
    
    private let backHeaderView = BackHeaderView()
    private let questionView = QuestionView()
    private let seperateLine = UIView()
    private let answerTextView = AnswerTextView()
    private let answerBottomView = AnswerBottomView()
    private let emotionView = EmotionView()
    private let emotionSheetView: SelectEmotionView
    private let backModal = MModalView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        emotionSheetView = SelectEmotionView(viewModel: viewModel, frame: .zero)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func bindViewModel() {
        backHeaderView.backButtonTapObservable
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                showBackModal()
            })
            .disposed(by: disposeBag)

        backHeaderView.rightButtonTapObservable
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.toggleQuestion()
            })
            .disposed(by: disposeBag)
        
        backModal.leftButtonTapObservable
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                backModal.isHidden = true
            })
            .disposed(by: disposeBag)
        
        backModal.rightButtonTapObservable
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        answerBottomView.registerButtonTapObservable
            .bind(to: viewModel.inputs.completeButtonTapped)
            .disposed(by: disposeBag)
        
        answerBottomView.togglePublicSwitch
            .bind(to: viewModel.inputs.toggleSwitch)
            .disposed(by: disposeBag)
        
        emotionSheetView.collectionViewRx.setDelegate(self)
            .disposed(by: disposeBag)
        
        emotionSheetView.confirmTapObservable
            .bind(to: viewModel.inputs.registerButtonTapped)
            .disposed(by: disposeBag)
        
        answerTextView.textViewRxText
            .orEmpty
            .bind(to: viewModel.inputs.inputText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.questionSubject
            .bind(onNext: { [weak self] question in
                guard let self else { return }
                self.questionView.setQuestion(data: question)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.showEmotionSubject
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.view.endEditing(true)
                self.showEmotionSheetView()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.toastSubject
            .bind(onNext: { [weak self] message in
                guard let self else { return }
                self.view.endEditing(true)
                self.showToast(message: message)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.countTextRelay
            .bind(to: answerBottomView.countTextObservable)
            .disposed(by: disposeBag)
        
        viewModel.outputs.inputTextRelay
            .bind(to: answerTextView.textViewRxText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.selectedEmotionIndexSubject
            .bind(onNext: { [weak self] indexPath in
                guard let self else { return }
                self.emotionView.isHidden = false
                self.emotionView.setEmotion(emotion: Emotions(intValue: indexPath.row + 1))
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.successRegisterSubject
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func setStyles() {
        backHeaderView.do {
            $0.setRightButton(image: UIImage(systemName: "chevron.down")!)
        }
        
        backModal.do {
            $0.isHidden = true
            $0.setModalTitle(title: "작성을 취소하고 나가시겠어요?", subTitle: "작성한 답변은 초기화돼요")
            $0.setModalButton(leftButtonTitle: "아니요", rightButtonTitle: "나갈래요")
        }
        
        emotionView.do {
            $0.isHidden = true
        }
        
        seperateLine.do {
            $0.backgroundColor = .Side300
        }
        
        emotionSheetView.do {
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        view.addSubviews(backHeaderView, questionView, seperateLine,
                         answerTextView, answerBottomView, emotionSheetView,
                         backModal)
        backHeaderView.addSubview(emotionView)
        
        backHeaderView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(77)
        }
        
        backModal.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emotionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        questionView.snp.makeConstraints {
            $0.top.equalTo(backHeaderView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        seperateLine.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(1)
        }
        
        answerTextView.snp.makeConstraints {
            $0.top.equalTo(seperateLine.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        answerBottomView.snp.makeConstraints {
            $0.top.equalTo(answerTextView.snp.bottom)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(72)
        }
        
        emotionSheetView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension AAnswerViewController {
    private func toggleQuestion() {
        questionView.isHidden.toggle()
        questionView.isHidden ? closeQuestion() : openQuestion()
    }
    
    private func openQuestion() {
        self.backHeaderView.setRightButton(image: UIImage(systemName: "chevron.down")!)
        
        self.questionView.snp.updateConstraints({
            $0.top.equalTo(self.backHeaderView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(120)
        })
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func closeQuestion() {
        self.backHeaderView.setRightButton(image: UIImage(systemName: "chevron.up")!)
        
        self.questionView.snp.updateConstraints({
            $0.top.equalTo(self.backHeaderView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0)
        })
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func showEmotionSheetView() {
        emotionSheetView.isHidden = false
        emotionSheetView.showOpenAnimation()
    }
    
    private func showBackModal() {
        backModal.isHidden = false
        backModal.showOpenAnimation()
    }
    
    private func setPremium() {
        backHeaderView.do {
            $0.setRightSecondButton(image: UIImage(named: "Switch"))
        }
    }
}

extension AAnswerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.frame.width - 3 * 56) / 3
    }
}
