//
//  SignUpViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.09.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

// baseviewcontroller 적용하기
final class SignUpViewController: UIViewController {
    private let viewModel = SignUpViewModel()

    private let disposeBag = DisposeBag()
    
    private let headerView = LogoHeaderView()
    private let skipButton = UIButton()
    private let progressView = GradientProgressBar(progressViewStyle: .bar)
    private let containerView = UIView()
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let leftButton = SecondaryIconButton()
    private let rightButton = SecondaryIconButton()
    private let infoview = BottomInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
        setDelegate()
        setPageViewController()
    }
}

extension SignUpViewController {
    private func bindViewModel() {
        skipButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.scrollToNextViewController()
            })
            .disposed(by: disposeBag)
        
        leftButton.rx.tap
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                self.scrollToPrevViewController()
            })
            .disposed(by: disposeBag)
        
        rightButton.rx.tap
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                switch viewModel.currentIndex {
                case 0:
                    scrollToNextViewController()
                    leftButton.isHidden = false
                case 1:
                    viewModel.checkNickname()
                case 2:
                    scrollToNextViewController()
                case 3:
                    viewModel.checkJobInfo()
                case 4:
                    viewModel.postSignUp()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        infoview.buttonTapObservable
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                infoview.isHidden = true
            })
            .disposed(by: disposeBag)
        
        Observable.zip(viewModel.agreementRelays[0], viewModel.agreementRelays[1])
            .bind { [weak self] (agreement1, agreement2) in
                guard let self else { return }
                if agreement1 && agreement2 {
                    rightButton.isEnabled = true
                } else {
                    rightButton.isEnabled = false
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.nicknameTextRelay
            .distinctUntilChanged()
            .bind(onNext: { [weak self] text in
                guard let self else { return }
                if text.count > 8 || text.count < 2 {
                    rightButton.isEnabled = false
                } else {
                    rightButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.checkNicknameSuccessSubject
            .skip(1)
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                scrollToNextViewController()
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedJobIndex
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                rightButton.isEnabled = true
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedPurposeIndex
            .bind(onNext: { [weak self] value in
                guard let self else { return }
                if value.isEmpty {
                    rightButton.isEnabled = false
                } else {
                    rightButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.checkJobInfoSuccessSubject
            .skip(1)
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                scrollToNextViewController()
            })
            .disposed(by: disposeBag)
        
        viewModel.showInfoSubject
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                infoview.setTitle(currentIndex: viewModel.currentIndex)
                infoview.isHidden = false
            })
            .disposed(by: disposeBag)
        
        viewModel.errorToastSubject
            .bind(onNext: { [weak self] message in
                guard let self else { return }
                showToast(message: message)
            })
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubviews(headerView, progressView, containerView,
                         leftButton, rightButton, infoview)
        headerView.addSubview(skipButton)
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(66)
        }
        
        skipButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(5)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom)
            $0.leading.equalToSuperview().inset(25)
            $0.size.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
        
        rightButton.snp.makeConstraints {
            $0.top.equalTo(leftButton.snp.top)
            $0.trailing.equalToSuperview().inset(25)
            $0.size.equalTo(55)
        }
        
        infoview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setStyles() {
        // 추후 지우기
        view.backgroundColor = .Side100
        
        skipButton.do {
            $0.isHidden = true
            $0.setTitle("건너뛰기", for: .normal)
            $0.setTitleColor(.Primary200, for: .normal)
        }
        
        progressView.do {
            $0.setProgress(Float(0)/Float(5), animated: true)
            $0.gradientColors = [
                UIColor(red: 0.486, green: 0.937, blue: 0.655, alpha: 1).cgColor,
                UIColor(red: 0.561, green: 0.827, blue: 0.957, alpha: 1).cgColor
            ]
        }

        leftButton.do {
            $0.isHidden = true
            $0.setSystemImage("arrow.backward")
        }
        
        rightButton.do {
            $0.isEnabled = false
            $0.setSystemImage("arrow.forward")
        }
        
        infoview.do {
            $0.isHidden = true
        }
    }
}

extension SignUpViewController {
    private func setPageViewController() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.didMove(toParent: self)
        pageViewController.setViewControllers([viewModel.viewControllers[0]], direction: .forward, animated: true)
    }
    
    private func setDelegate() {
        for subController in viewModel.viewControllers {
            guard let subController = subController as? SignUpBaseViewController else {
                return
            }
            subController.delegate = self
        }
    }
    
    private func scrollToNextViewController() {
        guard viewModel.currentIndex < viewModel.viewControllers.count - 1 else {
            return
        }
        
        pageViewController.setViewControllers([viewModel.viewControllers[viewModel.currentIndex + 1]], direction: .forward, animated: true)
        viewModel.currentIndex += 1
        
        if viewModel.currentIndex != 2 {
            skipButton.isHidden = true
            rightButton.isEnabled = false
        } else {
            skipButton.isHidden = false
        }
    }
    
    private func scrollToPrevViewController() {
        guard viewModel.currentIndex > 0 else {
            return
        }
        pageViewController.setViewControllers([viewModel.viewControllers[viewModel.currentIndex - 1]], direction: .reverse, animated: true)
        viewModel.currentIndex -= 1
    }
}

extension SignUpViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewModel.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if currentIndex > 0 {
            return viewModel.viewControllers[currentIndex - 1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewModel.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if currentIndex < viewModel.viewControllers.count - 1 {
            return viewModel.viewControllers[currentIndex + 1]
        }
        return nil
    }
}

extension SignUpViewController: SubPageViewControllerDelegate {
    func agreementStatusDidChange() {
        if viewModel.isAllAgree {
            rightButton.isEnabled = true
        } else {
            rightButton.isEnabled = false
        }
    }
    
    func nicknameDidChange() {
        
    }
    
    func selectedJobDidChange() {
        
    }
    
    func selectedPurposeDidChange() {
        
    }
    
}


