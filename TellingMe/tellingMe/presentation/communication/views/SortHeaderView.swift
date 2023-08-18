//
//  SortHeaderView.swift
//  tellingMe
//
//  Created by 마경미 on 01.08.23.
//

import UIKit

protocol SendSortDelegate: AnyObject {
    func changeSort(_ selectedSort: String)
}

class SortHeaderView: UICollectionReusableView {
    weak var delegate: SendSortDelegate?
    static let id = "sortHeaderView"

    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Side100")
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }

    func setView() {
        self.backgroundColor = UIColor(named: "Side100")
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        collectionView.register(ChipCollectionViewCell.self, forCellWithReuseIdentifier: ChipCollectionViewCell.id)
    }

    func selectCell(index: Int) {
        collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: [])
    }

//    func deselectCell(at indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//    }
}

extension SortHeaderView: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CommunicationData.shared.sortingList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCollectionViewCell.id, for: indexPath) as? ChipCollectionViewCell else {
            return UICollectionViewCell()
        }
//        print(CommunicationData.shared.sortingList[indexPath.row].rawValue)
        cell.setData(with: CommunicationData.shared.sortingList[indexPath.row].rawValue)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 63, height: 32)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CommunicationData.shared.currentSort = indexPath.row
        delegate?.changeSort(CommunicationData.shared.sortingList[indexPath.row].rawValue)
    }
}
