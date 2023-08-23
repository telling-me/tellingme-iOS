////
////  CommunicationListViewController.swift
////  tellingMe
////
////  Created by 마경미 on 31.07.23.
////

import UIKit
import RxSwift
import RxCocoa

class CommunicationListViewController: UIViewController {
    let viewModel = CommunicationListViewModel()
    var questionViewOriginalHeightConstraint: NSLayoutConstraint!
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let disposeBag = DisposeBag()

    let questionView: QuestionView = {
        let view = QuestionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let noneView: NoneCommunicationContentView = {
        let view = NoneCommunicationContentView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.alwaysBounceVertical = false
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = UIColor(named: "Side100")
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setInitialViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.getIntialCommunicationList()
        setView()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        // 정렬 기준이 바뀌었으면 다시 0부터 불러오기
        print(self.viewModel.currentSort, CommunicationData.shared.currentSortValue)
        if CommunicationData.shared.currentSortValue != viewModel.currentSort {
            viewModel.getIntialCommunicationList()
        }
        reloadCollectionView()
    }

    func setView() {
        view.backgroundColor = UIColor(named: "Side100")
        view.addSubview(questionView)
        questionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        questionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        questionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        questionViewOriginalHeightConstraint = questionView.heightAnchor.constraint(equalToConstant: 120)
        questionViewOriginalHeightConstraint.isActive = true
        questionView.setQuestion(data: QuestionResponse(date: viewModel.question.date, title: viewModel.question.title, phrase: viewModel.question.phrase))

        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: questionView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        collectionView.register(CommunicationDetailCollectionViewCell.self, forCellWithReuseIdentifier: CommunicationDetailCollectionViewCell.id)
        collectionView.register(SortHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SortHeaderView.id)

        view.addSubview(noneView)
        noneView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        noneView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        noneView.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 60).isActive = true
        noneView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func bindViewModel() {
        // communicationList 받기
        viewModel.communciationListSubject
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                if response.content.isEmpty {
                    self.noneView.isHidden = false
                } else {
                    self.noneView.isHidden = true
                }
                reloadCollectionView()
            }).disposed(by: disposeBag)
        viewModel.answerSuccessSubject
            .subscribe(onNext: { [weak self] response in
                self?.pushCommunicationAnswer(response)
                //                self?.collectionView.isUserInteractionEnabled = true
            }).disposed(by: disposeBag)
        viewModel.showToastSubject
            .subscribe(onNext: { [weak self] response in
                //                self?.collectionView.isUserInteractionEnabled = true
                self?.showToast(message: response)
            }).disposed(by: disposeBag)
    }

    // 맨 마지막 근처인지 확인하는 함수
    func isNearBottomEdge(scrollView: UIScrollView) -> Bool {
        let contentHeight = scrollView.contentSize.height
        let yOffset = scrollView.contentOffset.y
        let visibleHeight = scrollView.bounds.height

        // 마지막 아이템이 보여지는 시점에서만 불러오기 위한 변수 값
        let threshold: CGFloat = 10

        return yOffset + visibleHeight + threshold >= contentHeight - visibleHeight
    }

    func pushCommunicationAnswer(_ indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Communication", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "communicationAnswerViewController") as? CommunicationAnswerViewController else {
            return
        }
        viewController.viewModel.dataSubject.onNext(CommunicationAnswerViewModel.ReceiveData(index: viewModel.index, indexPath: indexPath, question: QuestionResponse(date: viewModel.question.date, title: viewModel.question.title, phrase: viewModel.question.phrase)))
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension CommunicationListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 50, height: 148)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 50, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CommunicationData.shared.communicationList[viewModel.index].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunicationDetailCollectionViewCell.id, for: indexPath) as? CommunicationDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.setData(index: viewModel.index, indexPath: indexPath, data: CommunicationData.shared.communicationList[viewModel.index][indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.fetchAnswerData(answerId: CommunicationData.shared.communicationList[viewModel.index][indexPath.row].answerId, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SortHeaderView.id, for: indexPath) as? SortHeaderView else {
                return UICollectionReusableView()
            }
            headerView.delegate = self
            headerView.selectCell(index: CommunicationData.shared.currentSort)
            return headerView
        }

        return UICollectionReusableView()
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.viewModel.isTop = true
        self.questionViewOriginalHeightConstraint.isActive = false
        self.questionViewOriginalHeightConstraint = self.questionView.heightAnchor.constraint(equalToConstant: 120)
        self.questionViewOriginalHeightConstraint.isActive = true

        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.isFetchingData {
            return // 이미 데이터를 가져오는 중이라면 무시
        }
        
        let contentOffset = scrollView.contentOffset
        if contentOffset.y <= 10 {
            // 스크롤을 위로 올릴 때의 작업을 여기에 수행합니다.
            if !self.viewModel.isTop {
                self.viewModel.isTop = true
                self.questionViewOriginalHeightConstraint.isActive = false
                self.questionViewOriginalHeightConstraint = self.questionView.heightAnchor.constraint(equalToConstant: 120)
                self.questionViewOriginalHeightConstraint.isActive = true

                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }

        if isNearBottomEdge(scrollView: scrollView) && !self.viewModel.isTop {
            viewModel.getCommunicationList()
            return
        }

        if contentOffset.y > 120 {
            if self.viewModel.isTop {
                self.viewModel.isTop = false
                self.questionViewOriginalHeightConstraint.isActive = false
                self.questionViewOriginalHeightConstraint = self.questionView.heightAnchor.constraint(equalToConstant: 0)
                self.questionViewOriginalHeightConstraint.isActive = true

                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}

extension CommunicationListViewController: SendLikeDelegate, SendSortDelegate, SendCurrentLikeDelegate {
    func likeButtonClicked(answerId: Int) {
        self.viewModel.postLike(answerId: answerId)
    }

    func changeSort(_ selectedSort: String) {
        viewModel.currentSort = selectedSort
        if CommunicationData.shared.communicationList[viewModel.index].count != 0 {
            self.viewModel.getIntialCommunicationList()
        }
    }

    func sendLike(isLike: Bool, likeCount: Int) {
        self.reloadCollectionView()
    }

}
