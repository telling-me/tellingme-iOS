//
//  LibraryViewController.swift
//  tellingMe
//
//  Created by 마경미 on 26.08.23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

//struct Data {
//
//}
//
//struct Header {
//
//}
//
//struct SectionOfLibrary {
//    var header: Header
//    var items: [Item]
//}
//
//extension SectionOfLibrary: SectionModelType {
//    typealias Item = Data
//    init(original: SectionOfLibrary, items: [Data]) {
//        self = original
//        self.items = items
//    }
//}

final class LibraryViewController: UIViewController {

    let viewModel = LibraryViewModel()
    let headerView = InlineHeaderView()
    let monthPickerView = UIPickerView()
    let yearPickerView = UIPickerView()
    let shareButton = UIButton()
    let descriptionLabel = Headline5Regular()
    let libraryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: HorizontalHeaderCollectionViewFlowLayout())
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
    }
}

extension LibraryViewController {
    private func bindViewModel() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, AnswerListResponse>>(
            configureCell: { dataSource, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.id, for: indexPath) as! LibraryCollectionViewCell
                cell.setData(emotion: 1)
                return cell
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekHeaderView.id, for: indexPath) as? WeekHeaderView else {
                    return WeekHeaderView()
                }
                headerView.setData(week: indexPath.section)
                return headerView
            })
         
         viewModel.outputs.answerLists
             .map { [SectionModel(model: "", items: $0)] }
             .bind(to: libraryCollectionView.rx.items(dataSource: dataSource))
             .disposed(by: disposeBag)
        Observable.just(viewModel.years)
            .bind(to: yearPickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        Observable.just(viewModel.months)
             .bind(to: monthPickerView.rx.itemTitles) { _, item in
                 return "\(item)"
             }
             .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        view.backgroundColor = .white
        yearPickerView.do{
            $0.tag = 2
            $0.backgroundColor = .blue
            $0.selectRow(viewModel.years.firstIndex(of: viewModel.selectedYear) ?? 0 , inComponent: 0, animated: false)
        }
        monthPickerView.do{
            $0.tag = 1
            $0.backgroundColor = .red
            $0.selectRow(viewModel.selectedMonth - 1, inComponent: 0, animated: false)
        }
        headerView.do {
            $0.setHeader(title: "나의 서재", buttonImage: "questionmark.circle")
        }
        descriptionLabel.do {
            $0.numberOfLines = 2
            $0.textColor = .black
            let attributedString = NSMutableAttributedString(string: "\(viewModel.selectedMonth)월 지금까지 \n 총 \(viewModel.answerListCount)권을 채웠어요!")
            let range = (attributedString.string as NSString).range(of: "\(viewModel.answerListCount)")
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
            $0.attributedText = attributedString
        }
    }
    
    private func setLayout() {
        view.addSubviews(headerView, yearPickerView, monthPickerView, descriptionLabel, libraryCollectionView)
        headerView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(yearPickerView.snp.top)
            $0.height.equalTo(66)
        }
        yearPickerView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(monthPickerView.snp.top)
            $0.width.equalTo(111)
            $0.height.equalTo(40)
        }
        monthPickerView.snp.makeConstraints {
            $0.leading.equalTo(yearPickerView.snp.trailing).offset(8)
            $0.width.equalTo(94)
            $0.height.equalTo(40)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(yearPickerView.snp.bottom).offset(36)
        }
        libraryCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(36)
            // tabbar에 가려짐 => tabbar 크기를 알아야하나용?
            $0.bottom.equalToSuperview().inset(88)
        }
    }
}
