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
    private let progressView = GradientProgressBar(progressViewStyle: .bar)
    private let containerView = UIView()
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let leftButton = SecondaryIconButton()
    private let rightButton = SecondaryIconButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
        setPageViewController()
    }
}

extension SignUpViewController {
    private func bindViewModel() {
        leftButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.scrollToPrevViewController()
            })
            .disposed(by: disposeBag)
        rightButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.scrollToNextViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubviews(headerView, progressView, containerView,
                         leftButton, rightButton)
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(66)
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
    }
    
    private func setStyles() {
        // 추후 지우기
        view.backgroundColor = .Side100
        
        progressView.do {
            $0.setProgress(Float(0)/Float(5), animated: true)
            $0.gradientColors = [
                UIColor(red: 0.486, green: 0.937, blue: 0.655, alpha: 1).cgColor,
                UIColor(red: 0.561, green: 0.827, blue: 0.957, alpha: 1).cgColor
            ]
        }

        leftButton.do {
            $0.setSystemImage("arrow.backward")
        }
        
        rightButton.do {
            $0.setSystemImage("arrow.forward")
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
    
    private func scrollToNextViewController() {
        guard viewModel.currentIndex < viewModel.viewControllers.count - 1 else {
            return
        }
        pageViewController.setViewControllers([viewModel.viewControllers[viewModel.currentIndex + 1]], direction: .forward, animated: true)
        viewModel.currentIndex += 1
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
