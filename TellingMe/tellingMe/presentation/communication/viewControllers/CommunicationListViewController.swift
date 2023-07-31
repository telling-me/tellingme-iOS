//
//  CommunicationListViewController.swift
//  tellingMe
//
//  Created by 마경미 on 31.07.23.
//

import UIKit

class CommunicationListViewController: UIViewController {
    let viewModel = CommunicationListViewModel()
    
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
//                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
//                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), elementKind: "", alignment: .topLeading)]
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                return section
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(63), heightDimension: .fractionalHeight(1)))
//                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(32)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
//                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: "", alignment: .topLeading)]
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                return section
            case 2:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(148)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 0)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
                group.contentInsets = .init(top: 0, leading: 25, bottom: 0, trailing: 25)
                let section = NSCollectionLayoutSection(group: group)
//                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), elementKind: "", alignment: .topLeading)]
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCollectionView()
    }

    func setView() {
        view.backgroundColor = UIColor(named: "Side100")
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        collectionView.register(QuestionCollectionViewCell.self, forCellWithReuseIdentifier: QuestionCollectionViewCell.id)
        collectionView.register(ChipCollectionViewCell.self, forCellWithReuseIdentifier: ChipCollectionViewCell.id)
        collectionView.register(CommunicationDetailCollectionViewCell.self, forCellWithReuseIdentifier: CommunicationDetailCollectionViewCell.id)
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
          return 3
      }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.sortList.count
        case 2:
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
            cell.setData(data: QuestionResponse(date: [2023, 3, 1], title: "텔링미를 사용하실 때 드는 기분은?", phrase: "하루 한번, 질문에 답변하며 나를 깨닫는 시간"))
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCollectionViewCell.id, for: indexPath) as? ChipCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setData(with: viewModel.sortList[indexPath.row])
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunicationDetailCollectionViewCell.id, for: indexPath) as? CommunicationDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setData(data: viewModel.communicationList[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isNearBottomEdge(scrollView: scrollView) {
            // 더 많은 소통 리스트 불러오기
//            loadMoreDataFromAPI()
        }
    }
}

class CommunicationList1ViewController: CommunicationListViewController {
    let date = CommunicationData.shared!.threeDays[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCommunicationList(date: date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadCollectionView()
    }
}

class CommunicationList2ViewController: CommunicationListViewController {
    let date = CommunicationData.shared!.threeDays[1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCommunicationList(date: date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadCollectionView()
    }
}

class CommunicationList3ViewController: CommunicationListViewController {
    let date = CommunicationData.shared!.threeDays[2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCommunicationList(date: date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadCollectionView()
    }
}
