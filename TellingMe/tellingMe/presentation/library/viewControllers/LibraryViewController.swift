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

final class LibraryViewController: UIViewController {
    let viewModel = LibraryViewModel()
    
    let yearDropdownButton = DropDownButton()
    let yearDropdown = UITableView()
    let monthDropdownButton = DropDownButton()
    let monthDropdown = UITableView()
    let headerView = InlineHeaderView()
    let infoButton = UIButton()
    let descriptionLabel = Headline5Regular()
    let libraryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: HorizontalHeaderCollectionViewFlowLayout())
    let libraryItem1 = UIImageView()
    let libraryItem2 = UIImageView()
    let bottomSheet = LibraryInfoView()

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
    }
    
    func toggleBottomSheet() {
        bottomSheet.isHidden.toggle()
        self.tabBarController?.tabBar.isHidden.toggle()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension LibraryViewController {
    private func bindViewModel() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, LibraryAnswerList>>(
            configureCell: { dataSource, collectionView, indexPath, item in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.id, for: indexPath) as? LibraryCollectionViewCell  else {
                    return UICollectionViewCell()
                }
                cell.setData(data: item)
                return cell
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekHeaderView.id, for: indexPath) as? WeekHeaderView else {
                        return UICollectionReusableView()
                    }
                    headerView.setData(week: indexPath.section + 1)
                    return headerView
                case UICollectionView.elementKindSectionFooter:
                    guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DividerFooterView.id, for: indexPath) as? DividerFooterView else {
                        return UICollectionReusableView()
                    }
                    return footerView
                default:
                    fatalError("Unsupported supplementary view kind")
                }
            })
        viewModel.years
            .bind(to: yearDropdown.rx.items(cellIdentifier: DropDownTableViewCell.id, cellType: DropDownTableViewCell.self)) { row, element, cell in
                cell.setCell(text: "\(element)년")
            }
            .disposed(by: disposeBag)
        viewModel.months
            .bind(to: monthDropdown.rx.items(cellIdentifier: DropDownTableViewCell.id, cellType: DropDownTableViewCell.self)) { row, element, cell in
                cell.setCell(text: "\(element)월")
            }
            .disposed(by: disposeBag)
        yearDropdown.rx.modelSelected(Int.self)
            .subscribe(onNext: { [weak self] item in
                self?.viewModel.selectedYear = item
                self?.viewModel.fetchAnswerList()
                self?.yearDropdownButton.setTitle(text: "\(item)년", isSmall: true)
                self?.yearDropdownButton.toggleOpen()
                self?.yearDropdown.isHidden.toggle()
            })
            .disposed(by: disposeBag)
        monthDropdown.rx.modelSelected(Int.self)
            .subscribe(onNext: { [weak self] item in
                self?.viewModel.selectedMonth = item
                self?.viewModel.fetchAnswerList()
                self?.monthDropdownButton.setTitle(text: "\(item)월", isSmall: true)
                self?.monthDropdownButton.toggleOpen()
                self?.monthDropdown.isHidden.toggle()
            })
            .disposed(by: disposeBag)
         viewModel.outputs.answerLists
            .map { list -> [SectionModel] in
                let groupedItems = list.chunked(into: 7)
                
                var sections = groupedItems.map { itemsChunk in
                    SectionModel(model: "header", items: itemsChunk)
                }
                
                return sections
            }
            .bind(to: libraryCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        viewModel.outputs.answerListCount
            .bind(onNext: { [weak self] count in
                self?.setDescriptionLabel(count: count)
            })
            .disposed(by: disposeBag)
        yearDropdownButton.tapped
            .bind(onNext: { [weak self] _ in
                self?.yearDropdownButton.toggleOpen()
                self?.yearDropdown.isHidden.toggle()
            })
            .disposed(by: disposeBag)
        monthDropdownButton.tapped
            .bind(onNext: { [weak self] _ in
                self?.monthDropdownButton.toggleOpen()
                self?.monthDropdown.isHidden.toggle()
            })
            .disposed(by: disposeBag)
        viewModel.outputs.toastSubject
            .skip(1)
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] message in
                self?.showToast(message: message)
            })
            .disposed(by: disposeBag)
        bottomSheet.okButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.toggleBottomSheet()
            })
            .disposed(by: disposeBag)
        headerView.rightButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.toggleBottomSheet()
            })
            .disposed(by: disposeBag)
    }
    
    private func setStyles() {
        view.backgroundColor = .Side100
        yearDropdownButton.do{
            $0.tag = 2
            $0.backgroundColor = .Side200
            $0.setSmallLayout()
            $0.setTitle(text: "\(viewModel.selectedYear)년", isSmall: true)
        }
        monthDropdownButton.do{
            $0.tag = 1
            $0.backgroundColor = .Side200
            $0.setSmallLayout()
            $0.setTitle(text: "\(viewModel.selectedMonth)월", isSmall: true)
        }
        monthDropdown.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 18
            $0.bounces = false
            $0.separatorStyle = .none
            $0.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.id)
            $0.isHidden = true
        }
        yearDropdown.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 18
            $0.bounces = false
            $0.separatorStyle = .none
            $0.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.id)
            $0.isHidden = true
        }
        headerView.do {
            $0.setHeader(title: "나의 서재", buttonImage: "Question")
        }
        descriptionLabel.do {
            $0.numberOfLines = 2
            $0.textColor = .Black
        }
        
        libraryCollectionView.do {
            $0.delegate = self
            $0.backgroundColor = .Side100
            $0.register(WeekHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekHeaderView.id)
            $0.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: LibraryCollectionViewCell.id)
            $0.register(DividerFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DividerFooterView.id)
        }
        libraryItem1.do {
            $0.image = UIImage(named: "LibraryItem1")
        }
        libraryItem2.do {
            $0.image = UIImage(named: "LibraryItem2")
        }
        bottomSheet.do {
            $0.isHidden = true
        }
    }
    
    private func setDescriptionLabel(count: Int) {
        if viewModel.selectedMonth == Int(Date().monthFormat()) {
            let attributedString = NSMutableAttributedString(string: "\(viewModel.selectedMonth)월 지금까지 \n총 \(count)권을 채웠어요!")
            let range = (attributedString.string as NSString).range(of: "\(count)")
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Logo, range: range)
            descriptionLabel.attributedText = attributedString
        } else {
            let attributedString = NSMutableAttributedString(string: "\(viewModel.selectedMonth)월 한 달 동안 \n총 \(count)권을 채웠어요!")
            let range = (attributedString.string as NSString).range(of: "\(count)")
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Logo, range: range)
            descriptionLabel.attributedText = attributedString
        }
    }

    private func setLayout() {
        view.addSubviews(headerView, yearDropdownButton, monthDropdownButton, descriptionLabel, libraryCollectionView, libraryItem1, libraryItem2, yearDropdown, monthDropdown, bottomSheet)
        headerView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(66)
        }
        yearDropdownButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(headerView.snp.bottom)
            $0.width.equalTo(111)
            $0.height.equalTo(40)
        }
        monthDropdownButton.snp.makeConstraints {
            $0.leading.equalTo(yearDropdownButton.snp.trailing).offset(8)
            $0.centerY.equalTo(yearDropdownButton.snp.centerY)
            $0.width.equalTo(94)
            $0.height.equalTo(40)
        }
        yearDropdown.snp.makeConstraints {
            $0.horizontalEdges.equalTo(yearDropdownButton.snp.horizontalEdges)
            $0.top.equalTo(yearDropdownButton.snp.bottom).offset(8)
            $0.height.equalTo(208)
        }
        monthDropdown.snp.makeConstraints {
            $0.horizontalEdges.equalTo(monthDropdownButton.snp.horizontalEdges)
            $0.top.equalTo(monthDropdownButton.snp.bottom).offset(8)
            $0.height.equalTo(208)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(yearDropdownButton.snp.bottom).offset(36)
        }
        libraryCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(36)
            $0.trailing.equalToSuperview().inset(96)
            // tabbar에 가려짐 => tabbar 크기를 알아야하나용?
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        libraryItem1.snp.makeConstraints {
            $0.width.equalTo(36)
            $0.height.equalTo(10)
            $0.top.equalTo(libraryCollectionView.snp.top).inset(327)
            $0.trailing.equalTo(libraryCollectionView.snp.trailing).inset(52)
        }
        libraryItem2.snp.makeConstraints {
            $0.width.height.equalTo(36)
            $0.top.equalTo(libraryCollectionView.snp.top).inset(301)
            $0.trailing.equalTo(libraryCollectionView.snp.trailing).inset(8)
        }
        bottomSheet.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: 18, height: 44)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 33, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 0, left: 73, bottom: 0, right: 0)
     }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
