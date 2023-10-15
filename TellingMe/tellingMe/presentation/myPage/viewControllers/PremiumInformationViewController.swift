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

import StoreKit

final class PremiumInformationViewController: UIViewController {

    private let inAppProducts = InAppProducts()
    private let viewModel = PremiumViewModel()
    private var disposeBag = DisposeBag()
    
    private let navigationBarView = CustomNavigationBarView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let informationImageView = UIImageView()
    private let infoContentView = UIView()
    private let infoStringImageView = UIImageView()
    private let termOfUseButton = UIButton()
    private let privacyButton = UIButton()
    private let bottomFixView = UIView()
    private let plusStackView = UIStackView()
    
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
//        readyButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                if SKPaymentQueue.canMakePayments() {
//                    if let product = self?.inAppProducts.subscriptionManager.product {
//                        let payment = SKPayment(product: product)
//                        SKPaymentQueue.default().add(payment)
//                    } else {
//                        // 상품 정보를 가져오지 못한 경우 처리
//                    }
//                } else {
//                    // 사용자의 기기에서 결제를 사용할 수 없음
//                    // 사용자에게 메시지를 표시하거나 다른 조치를 취할 수 있습니다.
//                }
//            })
//            .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        self.view.backgroundColor = .Side100
        
        navigationBarView.do {
            $0.setColor(with: .Side100)
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
        
        infoContentView.do {
            $0.backgroundColor = .Side200
        }
        
        infoStringImageView.do {
            $0.image = ImageLiterals.TellingMePlusInfoString
            $0.contentMode = .scaleAspectFill
        }
        
        termOfUseButton.do {
            $0.setTitle("이용약관", for: .normal)
            $0.setTitleColor(.Gray5, for: .normal)
        }
        
        privacyButton.do {
            $0.setTitle("개인정보처리방침", for: .normal)
            $0.setTitleColor(.Gray5, for: .normal)
        }
        
        bottomFixView.do {
            $0.backgroundColor = .Side100
            $0.layer.cornerRadius = 28
            $0.setShadow(shadowRadius: 20)
        }
        
        plusStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            
            for membership in viewModel.plusMemberships {
                let button = UIButton()
                button.setImage(membership.buttonImage, for: .normal)
                plusStackView.addArrangedSubview(button)
            }
        }
    }
    
    private func setLayout() {
        view.addSubviews(navigationBarView, scrollView, bottomFixView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(informationImageView, infoContentView)
        infoContentView.addSubviews(infoStringImageView, termOfUseButton, privacyButton)
        bottomFixView.addSubview(plusStackView)

        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(66)
            $0.horizontalEdges.equalToSuperview()
        }
        
//        readyButton.snp.makeConstraints {
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
//            $0.horizontalEdges.equalToSuperview().inset(25)
//            $0.height.equalTo(55)
//        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        informationImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(getWidthOfDevice() * 3.19)
        }
        
        infoContentView.snp.makeConstraints {
            $0.top.equalTo(informationImageView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(getWidthOfDevice() * 1.30)
            $0.bottom.equalToSuperview()
        }
        
        infoStringImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(31)
        }
        
        termOfUseButton.snp.makeConstraints {
            $0.top.equalTo(infoStringImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(34)
        }
        
        privacyButton.snp.makeConstraints {
            $0.top.height.equalTo(termOfUseButton)
            $0.leading.equalTo(termOfUseButton.snp.trailing).offset(8)
        }
        
        bottomFixView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(228)
        }
        
        plusStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

extension PremiumInformationViewController {
    private func getWidthOfDevice() -> CGFloat {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 1256 }
        return appDelegate.deviceWidth
    }
}
