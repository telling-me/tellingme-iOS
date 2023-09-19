//
//  BadFeedbackViewController.swift
//  tellingMe
//
//  Created by 마경미 on 12.09.23.
//

import UIKit
import SnapKit
import RxSwift

final class BadFeedbackViewController: UIViewController {
    private let headerView: InlineHeaderView = InlineHeaderView()
    private let scrollView: UIScrollView = UIScrollView()
    private let scrollContainerView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let captionLabel: UILabel = UILabel()
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let secondQuestionLabel: UILabel = UILabel()
    private let containerView: UIView = UIView()
    private let textView: CustomTextView = CustomTextView()
    private let bottomContainerView: UIView = UIView()
    private let submitButton: SecondaryTextButton = SecondaryTextButton()
    
    private let viewModel = BadFeedbackViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)
      self.view.endEditing(true)
    }
}

extension BadFeedbackViewController {
    private func bindViewModel() {
        viewModel.feedbackList
            .bind(to: collectionView.rx.items(cellIdentifier: BadFeedbackCollectionViewCell.id, cellType: BadFeedbackCollectionViewCell.self)) { (row, element, cell) in
                cell.setCell(text: element)
            }
            .disposed(by: disposeBag)
        headerView.rightButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        headerView.leftButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.popViewController()
            })
            .disposed(by: disposeBag)
        submitButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.postFeedback()
            })
            .disposed(by: disposeBag)
        collectionView.rx.itemSelected
            .bind(onNext: { [weak self] indexPath in
                
            })
            .disposed(by: disposeBag)
        collectionView.rx.itemDeselected
            .bind(onNext: { [weak self] indexPath in
                
            })
            .disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { [weak self] notification in
                guard let self = self else { return }
                guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
                let offsetY = self.textView.frame.maxY + keyboardSize.height
                self.scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
            })
            .disposed(by: disposeBag)

        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { [weak self] notification in
                self?.scrollView.contentInset.bottom = 0
            })
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubviews(headerView, scrollView, bottomContainerView)
        headerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(66)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-63)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
        }
        bottomContainerView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(63)
        }
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        scrollContainerView.addSubviews(titleLabel, captionLabel, collectionView, secondQuestionLabel, containerView)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(51)
        }
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(14)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(captionLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(348)
        }
        secondQuestionLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(38)
        }
        containerView.snp.makeConstraints {
            $0.top.equalTo(secondQuestionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(190)
            $0.bottom.equalToSuperview()
        }
        containerView.addSubview(textView)
        textView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.verticalEdges.equalToSuperview().inset(20)
        }
        bottomContainerView.addSubview(submitButton)
        submitButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setStyles() {
        view.backgroundColor = .Side100
        headerView.do {
            $0.setHeader(isFirstView: false, title: "소중한 피드백", buttonImage: "Xmark")
        }
        
        scrollView.do {
            $0.keyboardDismissMode = .onDrag
        }

        titleLabel.do {
            $0.font = .fontNanum(.H5_Bold)
            $0.textColor = .Gray6
            $0.numberOfLines = 2
            let text = "더 나은 텔링미가 될 수 있도록\n그 이유를 알려주세요! *"
            $0.text = text
            let attributedString = NSMutableAttributedString(string: text)
            let range = (attributedString.string as NSString).range(of: "*")
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Error400, range: range)
            $0.attributedText = attributedString
        }
        
        captionLabel.do {
            $0.text = "다중 선택 가능"
            $0.font = .fontNanum(.C1_Regular)
            $0.textColor = .Gray6
        }
        
        collectionView.do {
            $0.delegate = self
            $0.register(BadFeedbackCollectionViewCell.self, forCellWithReuseIdentifier: BadFeedbackCollectionViewCell.id)
            $0.allowsMultipleSelection = true
            $0.isScrollEnabled = false
        }
        
        secondQuestionLabel.do {
            $0.text = "그 외 하고 싶은 말을\n자유롭게 적어주세요."
            $0.textColor = .Gray8
            $0.font = .fontNanum(.B1_Regular)
            $0.numberOfLines = 2
        }
        
        containerView.do {
            $0.cornerRadius = 18
            $0.backgroundColor = .Side200
        }
        
        textView.do {
            $0.placeholder = "500자 이내"
            $0.backgroundColor = .clear
            $0.font = .fontNanum(.B1_Regular)
            $0.textColor = .Gray7
        }
        
        submitButton.do {
            $0.setText(text: "제출하기")
        }
    }
}

extension BadFeedbackViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
