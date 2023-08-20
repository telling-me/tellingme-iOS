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
    let leadingPadding: CGFloat = 36
    let itemSpacing: CGFloat = 21

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
        cell.setShadow(shadowRadius: 20)
        cell.layer.masksToBounds = false
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = answerList[indexPath.row].date.intArraytoDate() else {
            return
        }
        let storyboard = UIStoryboard(name: "AnswerCompleted", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "answerCompleted") as? AnswerCompletedViewController else {
            return
        }
        vc.setQuestionDate(date: data)
        self.navigationController?.pushViewController(vc, animated: true)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let availableWidth = collectionView.bounds.width - leadingPadding * 2
          let itemHeight = collectionView.bounds.height - leadingPadding * 2
          return CGSize(width: availableWidth, height: itemHeight)
      }

      // 컬렉션 뷰의 라인 간격 설정
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return itemSpacing
      }

      // 컬렉션 뷰의 아이템 간격 설정
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return itemSpacing
      }

      // 컬렉션 뷰의 인셋 설정
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 0, left: leadingPadding, bottom: 0, right: leadingPadding)
      }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemWidth = collectionView.bounds.width - (leadingPadding * 2)

        let collectionViewCenterX = targetContentOffset.pointee.x + collectionView.bounds.width / 2

        // 스크롤 방향을 확인하여 페이지를 결정합니다.
        let targetPage: CGFloat
        if velocity.x > 0 {
            targetPage = ceil(collectionViewCenterX / itemWidth)
        } else if velocity.x < 0 {
            targetPage = floor(collectionViewCenterX / itemWidth)
        } else {
            targetPage = round(collectionViewCenterX / itemWidth)
        }
        if targetPage == 0 {
            targetContentOffset.pointee = CGPoint(x: 0, y: targetContentOffset.pointee.y)
        } else if Int(targetPage) == answerList.count - 1 {
            targetContentOffset.pointee = CGPoint(x: CGFloat(answerList.count) * collectionView.bounds.width, y: targetContentOffset.pointee.y)
        } else {
            let offsetX = targetPage*(itemWidth + itemSpacing)
            // targetContentOffset을 변경하여 중앙 정렬을 구현합니다.
            targetContentOffset.pointee = CGPoint(x: offsetX, y: targetContentOffset.pointee.y)
        }
    }
}
