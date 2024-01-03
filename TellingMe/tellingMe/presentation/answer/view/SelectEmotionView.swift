//
//  SelectEmotionView.swift
//  tellingMe
//
//  Created by 마경미 on 25.11.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SelectEmotionView: BBaseView {
    private let disposeBag = DisposeBag()
    
    private let viewModel: AnswerViewModel
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let emotionLabel = UILabel()
    private let emotionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let buttonStackView = UIStackView()
    private let cancelButton = TeritaryTextButton()
    private let confirmButton = SecondaryTextButton()
    
    var collectionViewRx: Reactive<UICollectionView> {
        return emotionCollectionView.rx
    }
    
    var confirmTapObservable: Observable<Void> {
        return confirmButton.rx.tap.asObservable()
    }
    
    init(viewModel: AnswerViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bindViewModel() {
        cancelButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.isHidden = true
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.selectedEmotionIndexSubject
            .bind(onNext: { [weak self] indexPath in
                guard let self else { return }
                self.selectEmotion(indexPath: indexPath)
            })
            .disposed(by: disposeBag)

        Observable.just(viewModel.emotionList)
            .bind(to: emotionCollectionView.rx.items(cellIdentifier: EmotionCollectionViewCell.id, cellType: EmotionCollectionViewCell.self)) { (row, emotion, cell) in
                cell.setAlpha()
                cell.setCell(with: emotion.rawValue)
            }
            .disposed(by: disposeBag)
    }
    
    override func setStyles() {
        backgroundColor = .AlphaBlackColor
        
        contentView.do {
            $0.backgroundColor = .Side100
            $0.layer.cornerRadius = 28
            $0.setTopCornerRadius()
        }
        
        titleLabel.do {
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Black
            $0.text = AnswerStrings.emotionTitle.stringValue
        }
        
        emotionLabel.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray5
            $0.text = AnswerStrings.emotionPlaceHolder.stringValue
        }
        
        emotionCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] indexPath in
                guard let self else { return }
                self.viewModel.inputs.selectEmotion(indexPath: indexPath)
            })
            .disposed(by: disposeBag)
        
        emotionCollectionView.do {
            $0.backgroundColor = .Side100
            $0.register(EmotionCollectionViewCell.self, forCellWithReuseIdentifier: EmotionCollectionViewCell.id)
        }
        
        cancelButton.do {
            $0.setText(text: AnswerStrings.cancelTitle.stringValue)
        }
        
        confirmButton.do {
            $0.setText(text: AnswerStrings.confirmTitle.stringValue)
        }
        
        buttonStackView.do {
            $0.distribution = .fillEqually
            $0.spacing = 15
        }
    }
    
    override func setLayout() {
        addSubview(contentView)
        contentView.addSubviews(titleLabel, emotionLabel, emotionCollectionView,
            buttonStackView)
        buttonStackView.addArrangedSubviews(cancelButton, confirmButton)
        
        contentView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.centerX.equalToSuperview()
        }
        
        emotionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        emotionCollectionView.snp.makeConstraints {
            $0.top.equalTo(emotionLabel.snp.bottom).offset(32)
            $0.height.equalTo(132)
            $0.horizontalEdges.equalToSuperview().inset(55)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.top.equalTo(emotionCollectionView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(8)
        }
    }
}

extension SelectEmotionView {
    private func selectEmotion(indexPath: IndexPath) {
        if let cells = emotionCollectionView.visibleCells as? [EmotionCollectionViewCell] {
            cells.forEach {
                $0.setAlpha()
            }
        }
        
        if let cell = emotionCollectionView.cellForItem(at: indexPath) as? EmotionCollectionViewCell {
            cell.setOrigin()
        }
        self.emotionLabel.text = viewModel.emotionList[indexPath.row].stringValue
    }
}

extension SelectEmotionView {
    func showOpenAnimation() {
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.contentView.transform = .identity
        }
    }
}
