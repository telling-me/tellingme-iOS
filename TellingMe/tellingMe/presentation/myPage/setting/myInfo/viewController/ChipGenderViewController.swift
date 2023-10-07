//
//  ChipBirthdayViewController.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import UIKit

class ChipGenderViewController: ChipCollectionViewController {
    let genders = ["남성", "여성"]
    let genders_e = ["male", "female"]
    var alreadySelected: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        setItems(items: genders)
    }
}

extension ChipGenderViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let parentViewController = self.parent as? MyInfoViewController {
            parentViewController.viewModel.gender = genders_e[indexPath.row]
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCollectionViewCell.id, for: indexPath) as? ChipCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(with: items[indexPath.row])
        if let index = alreadySelected {
            cell.isUserInteractionEnabled = false
            if indexPath.row == index {
                cell.setSelected()
            } else {
                cell.setDisabled()
            }
        }
        return cell
    }
}
