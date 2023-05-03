//
//  EmotionViewController.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import UIKit

protocol EmotionDelegate: AnyObject {
    func emotionViewDidDismiss()
}

class EmotionViewController: UIViewController {
    let viewModel = EmotionViewModel()
    weak var delegate: EmotionDelegate?
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var label: Body2Regular!
    @IBOutlet weak var okButton: TeritaryTextButton!

    override func viewWillAppear(_ animated: Bool) {
        popView.frame.origin.y = popView.bounds.height

        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.popView.frame.origin.y -= self.popView.bounds.height
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.textColor = UIColor(named: "Gray5")
        okButton.isEnabled = false
        popView.setTopCornerRadius()
    }

    override func viewWillDisappear(_ animated: Bool) {
        view.backgroundColor = .clear
    }

    @IBAction func clickButton(_ sender: UIButton) {
        if sender.tag == 0 {
            self.dismiss(animated: true)
        } else {
            self.dismiss(animated: true) {
                    self.delegate?.emotionViewDidDismiss()
            }
        }
    }
}

extension EmotionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.emotionCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? EmotionCollectionViewCell else { return UICollectionViewCell()}
        cell.setData(with: viewModel.emotions[indexPath.row].image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 56, height: 56)
   }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectedEmotion = indexPath.row
        okButton.isEnabled = true
    }
}
