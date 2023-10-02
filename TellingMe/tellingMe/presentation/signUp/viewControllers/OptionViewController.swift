//
//  OptionViewController.swift
//  tellingMe
//
//  Created by 마경미 on 01.10.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class OptionViewController: SignUpBaseViewController {
    let genderList: Observable<[TeritaryBothData]> = Observable.just([
        TeritaryBothData(imgName: "Male", title: "남성"),
        TeritaryBothData(imgName: "Female", title: "여성")
    ])
    let selectedItem = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
    
    private let disposeBag = DisposeBag()
    
    private let inputBox = Input()
    private let genderTitleLabel = UILabel()
    private let genderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
}

extension OptionViewController {
    private func bindViewModel() {
        genderList
            .bind(to: genderCollectionView.rx.items(cellIdentifier: TeritaryVerticalBothButtonCell.id, cellType: TeritaryVerticalBothButtonCell.self)) {
                index, data, cell in
                cell.setData(with: data)
            }
            .disposed(by: disposeBag)
        genderCollectionView.rx.itemSelected
            .bind(to: selectedItem)
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubviews(inputBox, genderTitleLabel, genderCollectionView)
        
        inputBox.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        genderTitleLabel.snp.makeConstraints {
            $0.top.equalTo(inputBox.snp.bottom).offset(72)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(27)
        }
        
        genderCollectionView.snp.makeConstraints {
            $0.top.equalTo(genderTitleLabel.snp.bottom).offset(52)
            $0.horizontalEdges.equalToSuperview().inset(60)
            $0.height.equalTo(114)
        }
    }
    
    private func setStyles() {
        titleLabel.do {
            $0.text = "출생 연도를 알려주세요"
        }
        
        inputBox.do {
            $0.setBirthInput()
        }

        genderTitleLabel.do {
            $0.font = .fontNanum(.H4_Regular)
            $0.textColor = .Black
            $0.textAlignment = .center
            $0.text = "성별을 알려주세요"
        }
        
        genderCollectionView.do {
            $0.delegate = self
            $0.register(TeritaryVerticalBothButtonCell.self, forCellWithReuseIdentifier: TeritaryVerticalBothButtonCell.id)
        }
    }
}

extension OptionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = (collectionView.frame.width - 49) / 2
        return CGSize(width: cellwidth, height: 114)
    }
}

