//
//  LibraryInfoView.swift
//  tellingMe
//
//  Created by 마경미 on 30.08.23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class LibraryInfoView: UIView {
    let sheetView = UIView()
    let backgroundView = UIView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let okButton = SecondaryTextButton()
    
    let items = Observable.just(Emotions.standardEmotionArray() )
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func animate() {
        setSheetLayout()
    }
    
    func dismissAnimate() {
        setLayout()
    }
}

extension LibraryInfoView {
    func bindViewModel() {
        items
            .bind(to: collectionView.rx.items(
                cellIdentifier: LibraryInfoCollectionViewCell.id,
                cellType: LibraryInfoCollectionViewCell.self
            )) { row, element, cell in
                cell.setData(emotion: element)
            }
            .disposed(by: disposeBag)
    }
    func setLayout() {
        sheetView.snp.removeConstraints()
        addSubviews(backgroundView, sheetView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        sheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0)
        }
        sheetView.addSubviews(titleLabel, descriptionLabel, collectionView, okButton)
    }
    
    func setSheetLayout() {
        sheetView.snp.removeConstraints()
        sheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(42)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(67)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(115)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        okButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.11)
        }
    }
    
    func setStyles() {
        backgroundView.do {
            $0.backgroundColor = UIColor(red: 0.096, green: 0.096, blue: 0.096, alpha: 0.28)
        }
        sheetView.do {
            $0.layer.cornerRadius = 28
            $0.backgroundColor = .Side100
        }
        titleLabel.do {
            $0.font = .fontNanum(.B1_Regular)
            $0.textAlignment = .center
            $0.text = "책의 색은 감정의 색을 나타내요"
        }
        descriptionLabel.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray5
            $0.textAlignment = .center
            $0.text = "한 달 동안 감정의 흐름을 알 수 있어요"
        }
        collectionView.do {
            $0.backgroundColor = .Side100
            $0.delegate = self
            $0.register(LibraryInfoCollectionViewCell.self, forCellWithReuseIdentifier: LibraryInfoCollectionViewCell.id)
        }
        okButton.do {
            $0.setText(text: "확인")
        }
    }
}

extension LibraryInfoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sheetView.frame.width * 0.4, height: sheetView.frame.height * 0.125)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}
