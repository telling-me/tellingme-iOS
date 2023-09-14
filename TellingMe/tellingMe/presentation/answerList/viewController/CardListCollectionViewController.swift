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
    var row = 0
    let leadingPadding: CGFloat = 36
    let itemSpacing: CGFloat = 21

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.decelerationRate = .fast
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
        cell.delegate = self
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

        let cellWidthIncludingSpacing = targetContentOffset.pointee.x + collectionView.bounds.width / 2

        // 이동한 x좌표 값과 item의 크기를 비교 후 페이징 값 설정
        let estimatedIndex = cellWidthIncludingSpacing / itemWidth
        // 스크롤 방향 체크
        // item 절반 사이즈 만큼 스크롤로 판단하여 올림, 내림 처리
        if velocity.x > 0 {
            if row < answerList.count - 1 {
                row += 1
            }
        } else if velocity.x < 0 {
            if row > 0 {
                row -= 1
            }
        } else {
        }

        if row == 0 {
            targetContentOffset.pointee = CGPoint(x: 0, y: 0)
        } else if row == answerList.count - 1 {
            targetContentOffset.pointee = CGPoint(x: CGFloat(answerList.count - 1) * collectionView.bounds.width, y: 0)
        } else {
            targetContentOffset.pointee = CGPoint(x: row * Int((itemWidth + itemSpacing)), y: 0)
        }
    }
}

extension CardListCollectionViewController: ShareButtonTappedProtocol {
    func shareButtonTapped(passing view: UIView) {
        let bottomSheetViewController = SharingBottomViewController()
        bottomSheetViewController.modalPresentationStyle = .pageSheet
        bottomSheetViewController.passUIView(view)
        
        if let sheet = bottomSheetViewController.sheetPresentationController {
            sheet.detents = [.custom { _ in
                return 56 * 3 + 45
            }]
            sheet.preferredCornerRadius = 16
            sheet.prefersGrabberVisible = true
        }
        self.navigationController?.present(bottomSheetViewController, animated: true)
    }
}
