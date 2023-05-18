//
//  ChipBirthdayViewController.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import UIKit

class ChipGenderViewController: ChipCollectionViewController {
    let genders = ["남성", "여성"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setItems(items: genders)
    }
}

extension ChipGenderViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let parentViewController = self.parent as? MyInfoViewController {
            parentViewController.viewModel.gender = genders[indexPath.row]
        }
    }
}
