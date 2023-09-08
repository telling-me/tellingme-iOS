//
//  SignInViewController.swift
//  tellingMe
//
//  Created by 마경미 on 08.09.23.
//

import UIKit
import RxSwift
import RxCocoa

final class SignInViewController: UIViewController {

    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let kakaoButton: UIButton = UIButton(type: .custom)
    private let appleButton: UIButton = UIButton(type: .custom)
    private let stackView: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        setLayout()
        setStyles()
    }
}

extension SignInViewController {
    func bindViewModel() {
        
    }
    
    func setLayout() {
        view.addSubviews(collectionView, stackView)
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(220)
        }
        stackView.addArrangedSubviews(kakaoButton, appleButton)
    }
    
    func setStyles() {
        collectionView.do {
            $0.
        }
        
        kakaoButton.do {
            $0.backgroundColor = UIColor(hex: "#FEE500")
            $0.setTitle("카카오로 계속하기", for: .normal)
            $0.setImage(UIImage(named: "apple"), for: .normal)
            $0.titleLabel?.font = .fontNanum(.B1_Regular)
        }
        
        appleButton.do {
            $0.backgroundColor = .black
            $0.setTitle("Apple로 계속하기", for: .normal)
            $0.setImage(UIImage(named: "kakao"), for: .normal)
            $0.titleLabel?.font = .fontNanum(.B1_Regular)
        }
    }
}
