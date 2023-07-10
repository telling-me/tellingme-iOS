//
//  CardListCollectionViewController.swift
//  tellingMe
//
//  Created by 마경미 on 03.07.23.
//

import UIKit

class CardListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    static let id = "cardListCollectionViewController"
    var answerList: [AnswerListResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answerList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardListCollectionViewCell.id, for: indexPath) as? CardListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setCell(data: answerList[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let availableWidth = collectionView.bounds.width - padding * 2
        let itemHeight = collectionView.bounds.height - padding * 2 - 100

        return CGSize(width: availableWidth, height: itemHeight)
    }
}
