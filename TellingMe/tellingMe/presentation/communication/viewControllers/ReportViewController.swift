//
//  ReportViewController.swift
//  tellingMe
//
//  Created by 마경미 on 09.08.23.
//

import UIKit
import RxSwift
import RxCocoa

class ReportViewController: UIViewController {
    let viewModel = ReportViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var bottomSheetView: BottomSheet!

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomSheetView.setTitle(title: "답변 신고 사유를 선택해주세요", subTitle: "허위 신고 시 서비스 이용이 제한 될 수 있어요.")
        bottomSheetView.cancelButtonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        viewModel.selectedReport
            .map { $0 != nil } // 선택된 셀이 있을 때만 true 반환
            .bind(to: bottomSheetView.okButton.rx.isEnabled) // okButton의 활성화 여부에 바인딩
            .disposed(by: disposeBag)
        bottomSheetView.okButtonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.viewModel.postReport()
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension ReportViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let cellWidth = collectionView.frame.width / 2 - 15
          let cellHeight: CGFloat = 55 // 원하는 높이로 설정

        return CGSize(width: cellWidth, height: cellHeight)
      }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.reports.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportCollectionViewCell.id, for: indexPath) as? ReportCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setData(text: viewModel.reports[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectValue(indexPath.row + 1)
    }
}
