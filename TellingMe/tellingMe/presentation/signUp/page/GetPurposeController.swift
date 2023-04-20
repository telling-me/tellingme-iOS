//
//  GetWorryViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class GetPurposeViewController: UIViewController {
    let purposeList: [TeritaryBothData] = [TeritaryBothData(imgName: "Pen_Gradient", title: "학업/진로"), TeritaryBothData(imgName: "Handshake_Gradient", title: "대인 관계"), TeritaryBothData(imgName: "Values_Gradient", title: "성격/가치관"), TeritaryBothData(imgName: "Magnet_Gradient", title: "행동/습관"), TeritaryBothData(imgName: "Health_Gradient", title: "건강"), TeritaryBothData(imgName: "Heart_Gradient", title: "기타")]
    var selectedItems: [Int] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = true
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPage()
        SignUpData.shared.purpose = selectedItems.intArraytoString()
    }
    @IBAction func prevAction(_ sender: Any) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPage()
        self.dismiss(animated: true, completion: nil)
    }
}

extension GetPurposeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return purposeList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeritaryVerticalBothButtonCell.id, for: indexPath) as? TeritaryVerticalBothButtonCell else { return UICollectionViewCell() }
        cell.setData(with: purposeList[indexPath.row])
        cell.contentView.addSubview(UILabel())
        cell.layer.cornerRadius = 20
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 103, height: 114)
   }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView.indexPathsForSelectedItems!.count <  2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.indexPathsForSelectedItems!.count > 0 {
            nextButton.isEnabled = true
            selectedItems.append(indexPath.row)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView.indexPathsForSelectedItems!.count == 0 {
            nextButton.isEnabled = false
        } else {
            if let index = selectedItems.firstIndex(of: indexPath.row) {
                selectedItems.remove(at: index)
            }
        }
    }
}
