//
//  PurposeViewController.swift
//  tellingMe
//
//  Created by 마경미 on 15.05.23.
//

import UIKit

class ChipPurposeViewController: ChipCollectionViewController {
    let purposeList = ["학업/진로", "대인 관계", "성격/가치관", "행동/습관", "건강", "기타"]
    var selectedItems: [Int]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = true
        setItems(items: purposeList)
    }
}

extension ChipPurposeViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItems?.append(indexPath.row)
        if let parentViewController = self.parent as? MyInfoViewController {
            parentViewController.viewModel.purpose = self.selectedItems
        }
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView.indexPathsForSelectedItems!.count <  2
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let index = selectedItems?.firstIndex(of: indexPath.row) {
            selectedItems?.remove(at: index)
            if let parentViewController = self.parent as? MyInfoViewController {
                parentViewController.viewModel.purpose = self.selectedItems
            }
        }
    }
}
