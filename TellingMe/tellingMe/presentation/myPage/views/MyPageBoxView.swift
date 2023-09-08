//
//  MyPageBoxView.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class MyPageBoxView: UIView {
    
    private let viewModel = MyPageViewModel()
    private let disposeBag = DisposeBag()
    
    lazy var mainIconCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageBoxView {
    
    private func bindViewModel() {
        viewModel.outputs.boxElements
            .bind(to: mainIconCollectionView.rx.items(cellIdentifier: "mainIconBoxForMyPage", cellType: MyPageMainIconCollectionViewCell.self)) {
                index, data, cell in
                cell.configure(imageName: data.iconImage, title: data.iconTitle)
            }
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        self.addSubview(mainIconCollectionView)
        
        mainIconCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setStyles() {
        self.backgroundColor = .Side200
        self.cornerRadius = 20
        self.layer.masksToBounds = true
        
        mainIconCollectionView.do {
            $0.isScrollEnabled = false
            $0.register(MyPageMainIconCollectionViewCell.self, forCellWithReuseIdentifier: "mainIconBoxForMyPage")
            $0.backgroundColor = .clear
        }
    }
    
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return UICollectionViewFlowLayout() }
        let viewWidth: CGFloat = appDelegate.deviceWidth
        // Spacing of (View Width - 2*(insets) - 4*cellSize) / 3
        let lineSpace: CGFloat = (viewWidth - 2*(25 + 30) - 4*50)/3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = lineSpace
        flowLayout.itemSize = CGSize(width: 50, height: 60)
        return flowLayout
    }
}
