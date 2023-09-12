//
//  GoodFeedbackViewController.swift
//  tellingMe
//
//  Created by 마경미 on 12.09.23.
//

import UIKit
import RxSwift
import RxCocoa

final class GoodFeedbackViewController: UIViewController {
    private let viewModel = GoodFeedbackViewModel()
    private let disposeBag = DisposeBag()

    private let scrollView = UIScrollView()
    private let headerView = InlineHeaderView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let firstFeedbackView = FeedbackView()
    private let secondFeedbackView = FeedbackView()
    private let thirdFeedbackView = FeedbackView()
    private let lastFeedbackView = FeedbackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Side100
        bindViewModel()
        setLayout()
        setStyles()
    }
}

extension GoodFeedbackViewController {
    private func bindViewModel() {
//        firstFeedbackView.slider.rx.value
//            .bind(to: viewModel)
//            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        
    }
    
    private func setStyles() {
        
    }
}
