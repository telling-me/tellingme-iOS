//
//  CommunicationListViewController.swift
//  tellingMe
//
//  Created by 마경미 on 31.07.23.
//

import UIKit

class CommunicationListViewController: UIViewController {
    let viewModel = CommunicationListViewModel()

    var question: QuestionListResponse = QuestionListResponse(title: "텔링미를 사용하실 때 드는 기분은?", date: [2023, 3, 1], answerCount: 0, phrase: "")
    var index = 0

    private lazy var collectionView: UICollectionView = {
      let view = UICollectionView(frame: .zero, collectionViewLayout: self.getLayout())
      view.showsVerticalScrollIndicator = true
      view.contentInset = .zero
      view.backgroundColor = .clear
      view.clipsToBounds = true
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()

    // case 0 : questionView, case 1 : 정렬 뷰, case 2: 리스트 뷰
    func getLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                return section
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(148)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 0)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(CGFloat(self.viewModel.communicationList.count * 160))), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 25, bottom: 0, trailing: 25)

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
                let boundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                boundarySupplementaryItem.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [boundarySupplementaryItem]
                return section
            default:
                return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setView()
        self.getCommunicationList(date: question.date) {
            self.reloadCollectionView()
        }
    }

    func setView() {
        view.backgroundColor = UIColor(named: "Side100")
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        collectionView.register(QuestionCollectionViewCell.self, forCellWithReuseIdentifier: QuestionCollectionViewCell.id)
        collectionView.register(CommunicationDetailCollectionViewCell.self, forCellWithReuseIdentifier: CommunicationDetailCollectionViewCell.id)
        collectionView.register(SortHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SortHeaderView.id)
    }

    // 맨 마지막 근처인지 확인하는 함수
    func isNearBottomEdge(scrollView: UIScrollView) -> Bool {
        let contentHeight = scrollView.contentSize.height
        let yOffset = scrollView.contentOffset.y
        let visibleHeight = scrollView.bounds.height

        // 맨 아래가 아니라 그 근처로 가면 불러오기 위한 변수 값
        let threshold: CGFloat = 10

        return yOffset + visibleHeight + threshold >= contentHeight
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension CommunicationListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.communicationList.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCollectionViewCell.id, for: indexPath) as? QuestionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setData(data: QuestionResponse(date: question.date, title: question.title, phrase: question.phrase))

            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunicationDetailCollectionViewCell.id, for: indexPath) as? CommunicationDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setData(data: viewModel.communicationList[indexPath.row])
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        default:
            print("Wrong with section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         if kind == UICollectionView.elementKindSectionHeader {
             guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SortHeaderView.id, for: indexPath) as? SortHeaderView else {
                 return UICollectionReusableView()
             }

             return headerView
         }

         // Return a default view or nil for other kinds if needed
         return UICollectionReusableView()
     }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isNearBottomEdge(scrollView: scrollView) {
                // 더 많은 소통 리스트 불러오기
                //            loadMoreDataFromAPI()
        }
    }
}

extension CommunicationListViewController: SendLikeSignal {
    func sendLike(_ self: CommunicationDetailCollectionViewCell) {
        postLike(answerId: self.answerId) { isSuccess in
            if isSuccess {
                // 좋아요 성공
                self.likeButton.tintColor = .red
            } else {
                // 좋아요 실패
            }
        }
    }
}
