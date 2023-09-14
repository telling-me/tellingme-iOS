//
//  PremiumInformationViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/11.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import Then

final class PremiumInformationViewController: UIViewController {

    private let viewModel = MyPageViewModel()
    private var disposeBag = DisposeBag()
    
    private let navigationBarView = CustomNavigationBarView()
    private lazy var informationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    private let readyButton = UpcomingInformationButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
    }
    
    deinit {
        print("PremiumInformationVC Out")
    }
}

extension PremiumInformationViewController {
    
    private func bindViewModel() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfPremiumInformation> { _, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "premiumInfoView", for: indexPath) as? PremiumInformationCollectionViewCell else { return UICollectionViewCell() }
            cell.confiugre(imageName: item)
            print(item)
            return cell
        } configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "premiumInfoHeaderView", for: indexPath) as? PremiumInformationHeaderView else {
                    return UICollectionReusableView() }
                return headerView
            } else {
                guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "premiumInfoFooterView", for: indexPath) as? PremiumInformationFooterView else {
                    return UICollectionReusableView() }
                return footerView
            }
        }
        
        viewModel.outputs.premiumInformation
            .bind(to: informationCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        navigationBarView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        informationCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        view.backgroundColor = .Side100
        
        navigationBarView.do {
            $0.setTitle(with: "텔링미 PLUS")
        }
        
        informationCollectionView.do {
            $0.register(PremiumInformationCollectionViewCell.self, forCellWithReuseIdentifier: "premiumInfoView")
            $0.register(PremiumInformationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "premiumInfoHeaderView")
            $0.register(PremiumInformationFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "premiumInfoFooterView")
            $0.backgroundColor = .clear
            $0.isUserInteractionEnabled = true
            $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        }
        
        readyButton.setTitleFor("프리미엄 모드 출시 준비 중이에요!")
    }
    
    private func setLayout() {
        view.addSubviews(navigationBarView, readyButton, informationCollectionView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(66)
            $0.horizontalEdges.equalToSuperview()
        }
        
        readyButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(55)
        }
        
        informationCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalTo(readyButton.snp.top).offset(-10)
        }
    }
    
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.scrollDirection = .vertical
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let width = appDelegate.deviceWidth - 50
            let height = width / 1.81
            flowLayout.itemSize = CGSize(width: width, height: height)
            return flowLayout
        } else {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            return flowLayout
        }
    }
}

extension PremiumInformationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}
