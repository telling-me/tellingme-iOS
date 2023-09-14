//
//  LibraryViewController.swift
//  tellingMe
//
//  Created by 마경미 on 26.08.23.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift
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
    let descriptionTopLabel = UILabel()
    let descriptionBottomLabel = UILabel()
    let libraryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: HorizontalHeaderCollectionViewFlowLayout())
    let libraryItem1 = UIImageView()
    let libraryItem2 = UIImageView()
    let bottomSheet = LibraryInfoView()
    private let contentView = UIView()
    private let sharingIconButton = UIButton()

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchAnswerList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let collectionViewHeight = libraryCollectionView.frame.height
        libraryItem1.snp.makeConstraints {
            let offsetValue = collectionViewHeight * 0.07
               $0.bottom.equalTo(libraryCollectionView.snp.bottom).offset(-offsetValue)
           }
        libraryItem2.snp.makeConstraints {
            let offsetValue = collectionViewHeight * 0.07
               $0.bottom.equalTo(libraryCollectionView.snp.bottom).offset(-offsetValue)
           }
    }

    func toggleBottomSheet() {
        bottomSheet.isHidden.toggle()
        if bottomSheet.isHidden {
            bottomSheet.dismissAnimate()
        } else {
            bottomSheet.animate()
        }
        self.tabBarController?.tabBar.isHidden.toggle()

        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setDescriptionLabel(count: Int) {
        if viewModel.selectedMonth == Int(Date().monthFormat()) {
            descriptionTopLabel.text = "\(viewModel.selectedMonth)월 지금까지"
            let attributedString = NSMutableAttributedString(string: "총 \(count)권을 채웠어요!")
            let range = (attributedString.string as NSString).range(of: "\(count)")
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Logo, range: range)
            descriptionBottomLabel.attributedText = attributedString
        } else {
            descriptionTopLabel.text = "\(viewModel.selectedMonth)월 한 달 동안"
            let attributedString = NSMutableAttributedString(string: "총 \(count)권을 채웠어요!")
            let range = (attributedString.string as NSString).range(of: "\(count)")
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Logo, range: range)
            descriptionBottomLabel.attributedText = attributedString
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
        headerView.do {
            $0.setHeader(title: "나의 서재", buttonImage: "Question")
        }
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
        descriptionTopLabel.do {
            $0.numberOfLines = 1
            $0.font = .fontNanum(.H5_Regular)
            $0.textColor = .Black
        }
        descriptionBottomLabel.do {
            $0.numberOfLines = 1
            $0.font = .fontNanum(.H5_Regular)
            $0.textColor = .Black
        }
        libraryCollectionView.do {
            $0.delegate = self
            $0.backgroundColor = .Side100
            $0.isScrollEnabled = false
            $0.register(WeekHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekHeaderView.id)
            $0.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: LibraryCollectionViewCell.id)
            $0.register(DividerFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DividerFooterView.id)
        }
        libraryItem1.do {
            $0.image = UIImage(named: "LibraryItem1")
            $0.contentMode = .bottom
        }
        libraryItem2.do {
            $0.image = UIImage(named: "LibraryItem2")
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
        bottomSheet.do {
            $0.isHidden = true
        }
        
        sharingIconButton.do {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18)
            $0.setImage(UIImage(systemName: "square.and.arrow.up", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .Gray3
            $0.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(tapToShare), for: .touchUpInside)
        }
    }

    private func setLayout() {
        view.addSubviews(headerView, yearDropdownButton, monthDropdownButton, contentView, yearDropdown, monthDropdown, bottomSheet, sharingIconButton)
        contentView.addSubviews(descriptionTopLabel, descriptionBottomLabel, libraryCollectionView, libraryItem1, libraryItem2)
        
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
        
        contentView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(86)
            $0.top.equalTo(yearDropdownButton.snp.bottom).offset(36)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(113)
        }
        
        monthDropdownButton.snp.makeConstraints {
            $0.leading.equalTo(yearDropdownButton.snp.trailing).offset(8)
            $0.centerY.equalTo(yearDropdownButton.snp.centerY)
            $0.width.equalTo(94)
            $0.height.equalTo(40)
        }
        descriptionTopLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }
        descriptionBottomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(descriptionTopLabel.snp.bottom).offset(8)
        }
        libraryCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionBottomLabel.snp.bottom).offset(36)
            $0.leading.equalToSuperview().inset(11)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        libraryItem1.snp.makeConstraints {
            $0.width.equalTo(libraryCollectionView.snp.width).multipliedBy(0.13)
            $0.height.equalTo(libraryCollectionView.snp.height).multipliedBy(0.03)
            $0.trailing.equalTo(libraryItem2.snp.leading).offset(-8)
        }
        libraryItem2.snp.makeConstraints {
            $0.width.equalTo(libraryCollectionView.snp.width).multipliedBy(0.13)
            $0.height.equalTo(libraryCollectionView.snp.height).multipliedBy(0.1)
            $0.trailing.equalTo(libraryCollectionView.snp.trailing).offset(-9)
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
        bottomSheet.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        sharingIconButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.trailing.equalToSuperview().inset(21)
            $0.centerY.equalTo(yearDropdownButton.snp.centerY)
        }
    }
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame)
        let cellSize = CGSize(width: collectionView.frame.width * 0.07, height: collectionView.frame.height * 0.12)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 33, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.75, height: collectionView.frame.height * 0.08)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionView.frame.width * 0.32, bottom: 0, right: 0)
     }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

extension LibraryViewController {
    @objc
    private func tapToShare() {
        let bottomSheetViewController = SharingBottomViewController()
        bottomSheetViewController.modalPresentationStyle = .pageSheet
        bottomSheetViewController.passUIView(contentView)
        bottomSheetViewController.changeSharingViewType()
        
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
