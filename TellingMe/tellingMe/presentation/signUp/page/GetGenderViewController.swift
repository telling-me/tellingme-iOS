//
//  GetGenderViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class GetGenderViewController: UIViewController {
    @IBOutlet weak var nextButton: SecondayIconButton!
    @IBOutlet weak var prevButton: SecondayIconButton!
    let viewModel = GetGenderViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.setImage(image: "ArrowLeft")
        nextButton.isEnabled = false
        nextButton.setImage(image: "ArrowRight")
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPage()
        if let selectedItem = viewModel.selectedItem {
            SignUpData.shared.gender = selectedItem
        }
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPage()
    }
}

extension GetGenderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeritaryVerticalBothButtonCell.id, for: indexPath) as? TeritaryVerticalBothButtonCell else { return UICollectionViewCell() }
        cell.setData(with: viewModel.genderList[indexPath.row])
        cell.layer.cornerRadius = 20
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 103, height: 114)
   }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            viewModel.selectedItem = "male"
        } else {
            viewModel.selectedItem = "female"
        }
        nextButton.isEnabled = true
    }
}
