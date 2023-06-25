//
//  EmotionViewController.swift
//  tellingMe
//
//  Created by 마경미 on 28.04.23.
//

import UIKit

protocol EmotionDelegate: AnyObject {
    func emotionViewCancel()
    func emotionSelected(index: Int)
}

class EmotionViewController: UIViewController {
    let viewModel = EmotionViewModel()
    weak var delegate: EmotionDelegate?
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var label: Body2Regular!
    @IBOutlet weak var okButton: SecondaryTextButton!

    override func viewWillAppear(_ animated: Bool) {
        popView.frame.origin.y = popView.bounds.height

        guard let index = self.viewModel.selectedEmotion else {
            return
        }
        label.text = self.viewModel.emotions[index].text
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
            if let index = self.viewModel.selectedEmotion {
                self.dismiss(animated: true)
            } else {
                self.dismiss(animated: true)
                self.delegate?.emotionViewCancel()
            }
        } else {
            guard let index = self.viewModel.selectedEmotion else {
                self.showToast(message: "감정을 선택해주세요")
                return
            }
            self.delegate?.emotionSelected(index: index)
            self.dismiss(animated: true)
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
        
        if let selectedIndexPath = viewModel.selectedEmotion {
            if selectedIndexPath == indexPath.row {
                // 선택된 셀이면 표시합니다
                cell.isSelected = true
                cell.imageView.alpha = 1.0
            } else {
                // 선택되지 않은 셀은 투명하게 처리합니다.
                cell.isSelected = false
                cell.imageView.alpha = 0.5
            }
        }
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
        self.label.text = self.viewModel.emotions[indexPath.row].text
        okButton.isEnabled = true

        collectionView.reloadData()
    }
}
