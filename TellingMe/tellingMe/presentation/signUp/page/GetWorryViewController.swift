//
//  GetWorryViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

struct WorryViewModel {
    let title: String
    let imgName: String

    init(imgName: String, title: String) {
        self.title = title
        self.imgName = imgName
    }
}

class GetWorryViewController: UIViewController {
    var selected: [IndexPath] = []
    let worryList: [WorryViewModel] = [WorryViewModel(imgName: "Pen", title: "학업/진로"), WorryViewModel(imgName: "Handshake", title: "대인 관계"), WorryViewModel(imgName: "Values", title: "성격/가치관"), WorryViewModel(imgName: "Magnet", title: "행동/습관"), WorryViewModel(imgName: "Health", title: "건강"), WorryViewModel(imgName: "Heart", title: "기타")]
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = true
    }
    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPageWithIndex(index: 3)
    }
    @IBAction func prevAction(_ sender: Any) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 1)
        self.dismiss(animated: true, completion: nil)
    }
}

extension GetWorryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return worryList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorryCollectionViewCell.id, for: indexPath) as? WorryCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(with: worryList[indexPath.row])
        cell.layer.cornerRadius = 20
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 103, height: 114)
   }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView.indexPathsForSelectedItems!.count
        <  2
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.indexPathsForSelectedItems!.count > 0 {
            nextButton.isEnabled = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView.indexPathsForSelectedItems!.count == 0 {
            nextButton.isEnabled = false
        }
    }
}
