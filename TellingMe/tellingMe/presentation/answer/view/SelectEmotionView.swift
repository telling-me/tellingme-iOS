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
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let emotionLabel = UILabel()
    private let emotionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let buttonStackView = UIStackView()
    private let cancelButton = TeritaryTextButton()
    private let confirmButton = SecondaryTextButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bindViewModel() {
        viewModel.emotionList
            .bind(to: emotionCollectionView.rx.items(cellIdentifier: EmotionCollectionViewCell.id, cellType: EmotionCollectionViewCell.self)) { (row, element, cell) in
            cell.setCell(data: element)
        }
            .disposed(by: disposeBag)
            
    }
    
    override func setStyles() {
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
        
        cancelButton.do {
            $0.setText(text: AnswerStrings.cancelTitle.stringValue)
        }
        
        confirmButton.do {
            $0.setText(text: AnswerStrings.confirmTitle.stringValue)
        }
    }
    
    override func setLayout() {
        addSubview(contentView)
        contentView.addSubviews(titleLabel, emotionLabel, emotionCollectionView,
            buttonStackView)
        buttonStackView.addArrangedSubviews(cancelButton, confirmButton)
        
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
