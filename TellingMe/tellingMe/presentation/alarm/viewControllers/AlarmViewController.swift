//
//  AlarmViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import UIKit

import RxCocoa
import RxMoya
import RxSwift

final class AlarmViewController: UIViewController {

    private let navigationBarView = AlarmNavigationBarView()
    private let alarmSectionView = AlarmReadAllSectionView()
    private let alarmNoticeTableView = UITableView(frame: .zero)
    
    private var disposeBag = DisposeBag()
    private let viewModel = AlarmNoticeViewModel()
    private lazy var isNoticeAllRead: BehaviorRelay<Bool> = viewModel.outputs.isAlarmAllRead
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
    }

    deinit {
        print("AlarmView Dismissed.")
    }
}

extension AlarmViewController {
    private func bindViewModel() {
        navigationBarView.dismissButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        alarmSectionView.readAllButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.inputs.readAllNotice()
                self?.alarmSectionView.isAllNoticeRead(true)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.alarmNotices
            .bind(to: alarmNoticeTableView.rx.items(cellIdentifier: "noticeTableView", cellType: AlarmTableViewCell.self)) {
                index, data, cell in
                cell.configrue(noticeData: data)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        Observable.zip(alarmNoticeTableView.rx.itemSelected, alarmNoticeTableView.rx.modelSelected(AlarmNotificationResponse.self))
            .subscribe(onNext: { [weak self] indexPath, item in
                guard let cell = self?.alarmNoticeTableView.cellForRow(at: indexPath) as? AlarmTableViewCell else { return }
                cell.noticeIsRead()
                let hasLinkToSafari = cell.hasOutboundLink()
                let answerId = cell.getAnswerId()
                
                if hasLinkToSafari != false {
                    // 외부 링크로 나가기
                }

                if let answerId = answerId {
                    if answerId == -1 {
                        // 나의 서재로 넘어가기
                        // self?.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
                    } else {
                        print(item)
                        // answerId 를 가지고 answer 화면으로 넘어가기
                        // self?.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        alarmNoticeTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                do {
                    var newData: [AlarmNotificationResponse] = []
                    guard let dataChanged = try self?.viewModel.outputs.alarmNotices.value() else { return }
                    newData = dataChanged
                    newData.remove(at: indexPath.row)
                    self?.viewModel.outputs.alarmNotices.onNext(newData)
                } catch let error {
                    print(error)
                }
            })
            .disposed(by: disposeBag)
        
        alarmNoticeTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
        
    private func setStyles() {
        view.backgroundColor = .Side100
        
        alarmNoticeTableView.do {
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 74
            $0.backgroundColor = .Side100
            $0.separatorColor = .Gray1
            $0.register(AlarmTableViewCell.self, forCellReuseIdentifier: "noticeTableView")
        }
        
        alarmSectionView.do {
            $0.isAllNoticeRead(false)
        }
    }

    private func setLayout() {
        view.addSubviews(navigationBarView, alarmSectionView, alarmNoticeTableView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(66)
            $0.horizontalEdges.equalToSuperview()
        }
        
        alarmSectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.height.equalTo(38)
            $0.horizontalEdges.equalToSuperview()
        }
        
        alarmNoticeTableView.snp.makeConstraints {
            $0.top.equalTo(alarmSectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension AlarmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (action, view, completionHandler) in
            guard let cell = tableView.cellForRow(at: indexPath) as? AlarmTableViewCell else { return }
            guard let answerId = cell.getAnswerId() else { return }
            self?.viewModel.inputs.deleteNotice(idOf: answerId)
            completionHandler(true)
        }
        
        let action = UISwipeActionsConfiguration(actions: [swipeAction])

        return action
    }
}

