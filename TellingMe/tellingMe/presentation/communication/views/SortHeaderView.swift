//
//  SortHeaderView.swift
//  tellingMe
//
//  Created by 마경미 on 01.08.23.
//

import UIKit

class SortHeaderView: UICollectionReusableView {
    var sortList: [String] = ["인기순", "관련순", "최신순"]
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
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        collectionView.register(ChipCollectionViewCell.self, forCellWithReuseIdentifier: ChipCollectionViewCell.id)
    }
}

extension SortHeaderView: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCollectionViewCell.id, for: indexPath) as? ChipCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(with: sortList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 63, height: 32)
    }
}
