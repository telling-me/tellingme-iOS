//
//  SignInViewController.swift
//  tellingMe
//
//  Created by 마경미 on 08.09.23.
//

import UIKit
import RxSwift
import RxCocoa
import AuthenticationServices

final class OnBoardingViewController: UIViewController {
    
    private let viewModel: OnBoardingViewModel = OnBoardingViewModel()
    private let disposeBag = DisposeBag()
    private let pagingIndicatorView = UIView()
    private let pagingStackView = UIStackView()
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let kakaoButton: UIButton = UIButton(type: .custom)
    private let appleButton: UIButton = UIButton(type: .custom)
    private let stackView: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    private func scrollCollectionView() {
        pagingStackView.arrangedSubviews[viewModel.currentPage].backgroundColor = .Gray5
        if viewModel.currentPage >= viewModel.itemCount - 1 {
            viewModel.currentPage = 0
        } else {
            viewModel.currentPage += 1
        }
        
        let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
         collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pagingStackView.arrangedSubviews[viewModel.currentPage].backgroundColor = .Logo
    }
    
    private func pushHome() {
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }
        vc.selectedIndex = 0
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    private func pushSignUp() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "signUp") as? SignUpViewController else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension OnBoardingViewController {
    private func bindViewModel() {
        viewModel.items
            .bind(to: collectionView.rx.items(cellIdentifier: OnBoardingCollectionViewCell.id, cellType: OnBoardingCollectionViewCell.self)) { (row, element, cell) in
                cell.setData(data: element)
            }
            .disposed(by: disposeBag)
        Observable<Int>.interval(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                self?.scrollCollectionView()
            })
            .disposed(by: disposeBag)
        kakaoButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.callKakaoAPI()
            })
            .disposed(by: disposeBag)
        appleButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.callAppleAPI()
            })
            .disposed(by: disposeBag)
        viewModel.outputs.signInSubject
            .skip(1)
            .bind(onNext: { [weak self] _ in
                self?.pushHome()
            })
            .disposed(by: disposeBag)
        viewModel.outputs.signUpSubject
            .skip(1)
            .bind(onNext: { [weak self] _ in
                self?.pushSignUp()
            })
            .disposed(by: disposeBag)
        viewModel.outputs.toastSubject
            .bind(onNext: { [weak self] message in
                self?.showToast(message: message)
            })
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubviews(pagingIndicatorView, collectionView, stackView)
        pagingIndicatorView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        pagingIndicatorView.addSubview(pagingStackView)
        pagingStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(6)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(pagingIndicatorView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.height.equalTo(104)
        }
    }
    
    private func setStyles() {
        view.backgroundColor = .Side100
    
        pagingStackView.do {
            for i in 0..<3 {
                let dot: UIView = {
                    let view = UIView()
                    view.layer.cornerRadius = 3
                    view.backgroundColor = i == 0 ? .Logo : .Gray5
                    view.tag = i
                    return view
                }()
                $0.addArrangedSubview(dot)
            }
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 11
        }

        layout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
        }
    
        collectionView.do {
            $0.delegate = self
            $0.backgroundColor = .Side100
            $0.isPagingEnabled = true
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.register(OnBoardingCollectionViewCell.self, forCellWithReuseIdentifier: OnBoardingCollectionViewCell.id)
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 12
            $0.addArrangedSubviews(appleButton, kakaoButton)
        }
        
        appleButton.do {
            var config = UIButton.Configuration.plain()
            config.title = "Apple로 계속하기"
            config.image = UIImage(named: "Apple")
            config.imagePadding = 8
            config.attributedTitle?.font = .fontNanum(.B1_Regular)
            $0.configuration = config

            $0.backgroundColor = .black
            $0.layer.cornerRadius = 8
            $0.tintColor = .white
        }

        kakaoButton.do {
            var config = UIButton.Configuration.plain()
            config.title = "카카오로 계속하기"
            config.image = UIImage(named: "Kakao")
            config.imagePadding = 8
            config.attributedTitle?.font = .fontNanum(.B1_Regular)
            $0.configuration = config

            $0.backgroundColor = UIColor(hex: "#FEE500")
            $0.layer.cornerRadius = 8
            $0.tintColor = .black
        }
    }
}

extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pagingStackView.arrangedSubviews[viewModel.currentPage].backgroundColor = .Gray5
        let itemWidth = collectionView.bounds.width

        if velocity.x > 0 {
            if viewModel.currentPage < viewModel.itemCount - 1 {
                viewModel.currentPage += 1
            }
        } else if velocity.x < 0 {
            if viewModel.currentPage > 0 {
                viewModel.currentPage -= 1
            }
        } else {
        }

        if viewModel.currentPage == 0 {
            targetContentOffset.pointee = CGPoint(x: 0, y: 0)
        } else if viewModel.currentPage == viewModel.itemCount - 1 {
            targetContentOffset.pointee = CGPoint(x: CGFloat(viewModel.itemCount - 1) * collectionView.bounds.width, y: 0)
        } else {
            targetContentOffset.pointee = CGPoint(x: viewModel.currentPage * Int(itemWidth), y: 0)
        }
        
        let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pagingStackView.arrangedSubviews[viewModel.currentPage].backgroundColor = .Logo
    }
}

extension OnBoardingViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func callAppleAPI() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            if let identityToken = appleIDCredential.identityToken,
               let tokenString = String(data: identityToken, encoding: .utf8) {
                KeychainManager.shared.save(tokenString, key: Keys.idToken.rawValue)
                self.viewModel.signIn(type: "apple", oauthToken: tokenString)
            }

        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password


        default:
            break
        }
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first!
        }
        fatalError("No UIWindowScene available")
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error, "error occured")
    }
}

