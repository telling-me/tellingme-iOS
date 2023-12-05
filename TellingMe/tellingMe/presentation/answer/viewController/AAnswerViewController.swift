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
    
    override func bindViewModel() {
        backHeaderView.backButtonTapObservable
            .bind(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

        backHeaderView.rightButtonTapObservable
            .bind(onNext: {
                self.toggleQuestion()
            })
            .disposed(by: disposeBag)
        
        answerBottomView.registerButtonTapObservable
            .bind(onNext: {
                self.showEmotionSheetView()
            })
            .disposed(by: disposeBag)
        
        emotionSheetView.emotionCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        emotionSheetView.emotionCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.viewModel.inputs.selectEmotion(indexPath: indexPath)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.questionSubject
            .bind(onNext: { question in
                self.questionView.setQuestion(data: question)
            })
            .disposed(by: disposeBag)
        
        Observable.just(viewModel.emotionList)
            .bind(to: emotionSheetView.emotionCollectionView.rx.items(cellIdentifier: EmotionCollectionViewCell.id, cellType: EmotionCollectionViewCell.self)) { (row, emotion, cell) in
                cell.setAlpha()
                cell.setCell(with: emotion.rawValue)
            }
            .disposed(by: disposeBag)
    }
    
    override func setStyles() {
        backHeaderView.do {
            $0.setRightButton(image: UIImage(systemName: "chevron.down")!)
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
                         answerTextView, answerBottomView, emotionSheetView)
        backHeaderView.addSubview(emotionView)
        
        backHeaderView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(77)
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
            $0.bottom.equalTo(view.keyboardLayoutGuide).inset(34)
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
