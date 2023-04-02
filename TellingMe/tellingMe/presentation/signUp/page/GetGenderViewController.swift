//
//  GetGenderViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class GetGenderViewController: UIViewController {
    let genderList: [TeritaryBothData] = [TeritaryBothData(imgName: "Man", title: "남성"), TeritaryBothData(imgName: "Woman", title: "여성")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPageWithIndex(index: 5)
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 3)
    }
}

extension GetGenderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderCollectionViewCell.id, for: indexPath) as? GenderCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(with: genderList[indexPath.row])
        cell.layer.cornerRadius = 20
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 103, height: 114)
   }
}
