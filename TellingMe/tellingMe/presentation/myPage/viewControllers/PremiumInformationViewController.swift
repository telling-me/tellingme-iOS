//
//  PremiumInformationViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/11.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class PremiumInformationViewController: UIViewController {

    private var disposeBag = DisposeBag()
    
    private let backgroundView = UIView()
    private let navigationBarView = CustomNavigationBarView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let readyButton = UpcomingInformationButton()
    private let informationImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
    }
    
    deinit {
        print("TellingEBookViewController Out")
    }
}

extension PremiumInformationViewController {
    
    private func bindViewModel() {
        navigationBarView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        self.view.backgroundColor = .Side100
        
        backgroundView.do {
            $0.backgroundColor = .Side100
        }
        
        navigationBarView.do {
            $0.setColor(with: .EBookNavigationColor)
            $0.setTitle(with: "텔링미 PLUS")
        }
        
        scrollView.do {
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = true
        }
        
        informationImageView.do {
            $0.image = UIImage(named: "TellingMePlusInfo")
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
        }
        
        readyButton.setTitleFor("프리미엄 모드 출시 준비 중이에요!")
    }
    
    private func setLayout() {
        view.addSubviews(backgroundView, navigationBarView, readyButton, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(informationImageView)
        
        backgroundView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(400)
        }
        
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
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(readyButton.snp.top).offset(-10)
        }
        
        contentView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        informationImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(getHeightOfScrollView())
            $0.bottom.equalToSuperview().inset(40)
        }
    }
}

extension PremiumInformationViewController {
    private func getHeightOfScrollView() -> CGFloat {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 1128 }
        return appDelegate.deviceWidth * 3.01
    }
}
