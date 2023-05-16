//
//  CpasuleCollectionViewController.swift
//  tellingMe
//
//  Created by 마경미 on 15.05.23.
//

import UIKit

class CapsuleCollectionViewController: UIViewController {
    var items: [String] = []

    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        collectionView.register(CapsuleCollectionViewCell.self, forCellWithReuseIdentifier: CapsuleCollectionViewCell.id)

        collectionView.isScrollEnabled = false
    }

    func setItems(items: [String]) {
        self.items = items
    }
}

extension CapsuleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CapsuleCollectionViewCell.id, for: indexPath) as? CapsuleCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setData(with: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = items[indexPath.item]
        let font = UIFont(name: "NanumSquareRoundOTFR", size: 14)

        let label = UILabel()
        label.font = font
        label.text = text
        label.numberOfLines = 0
        label.sizeToFit()

        let cellWidth = label.frame.size.width + 24

        return CGSize(width: cellWidth, height: 32)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 16) // 셀 상하좌우 간격

        return inset
    }
}
