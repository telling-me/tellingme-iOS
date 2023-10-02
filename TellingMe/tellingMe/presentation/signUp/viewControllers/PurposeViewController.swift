//
//  PurposeViewController.swift
//  tellingMe
//
//  Created by 마경미 on 02.10.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class PurposeViewController: SignUpBaseViewController {
    private let disposeBag = DisposeBag()
    private let captionLabel = UILabel()
    private let purposeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let purposeList: Observable<[TeritaryBothData]> = Observable.just([
            TeritaryBothData(imgName: "Pen", title: "학업/진로"),
            TeritaryBothData(imgName: "Handshake", title: "대인 관계"),
            TeritaryBothData(imgName: "Values", title: "성격/가치관"),
            TeritaryBothData(imgName: "Magnet", title: "행동/습관"),
            TeritaryBothData(imgName: "Health", title: "건강"),
            TeritaryBothData(imgName: "Etc", title: "기타")
        ])
    let selectedItem = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
}

extension PurposeViewController {
    private func bindViewModel() {
        purposeList
            .bind(to: purposeCollectionView.rx.items(cellIdentifier: TeritaryVerticalBothButtonCell.id, cellType: TeritaryVerticalBothButtonCell.self)) { index, data, cell in
                cell.setData(with: data)
            }
            .disposed(by: disposeBag)
        purposeCollectionView.rx.itemSelected
            .bind(to: selectedItem)
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubviews(captionLabel, purposeCollectionView)
        
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        purposeCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(60)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setStyles() {
        captionLabel.do {
            $0.font = .fontNanum(.B2_Regular)
            $0.textColor = .Gray6
            $0.textAlignment = .center
        }
        
        purposeCollectionView.do {
            $0.delegate = self
            $0.allowsMultipleSelection = true
            $0.register(TeritaryVerticalBothButtonCell.self, forCellWithReuseIdentifier: TeritaryVerticalBothButtonCell.id)
        }
    }
}

extension PurposeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 103, height: 114)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView.indexPathsForSelectedItems!.count <  2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}
