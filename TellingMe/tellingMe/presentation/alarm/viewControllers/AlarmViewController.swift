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
        AlarmNotificationAPI.getAllAlarmNoticeWithClosure { result in
            print(result)
        }
        
        
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
        
        /**
         이게 문제가 생기면 이걸로
         Observable.zip(tableView.rx.modelSelected(Item.self), tableView.rx.itemSelected)
             .bind { [weak self] (item, indexPath) in
                     print(item.name)
                     self?.tableView.deselectRow(at: indexPath, animated: true)
             }
             disposed(by: disposeBag)
         -> IndexPath 가 필요한 경우일 수 있잖아.
         ❓ Deselect 가 꼭 들어가야할까?
         */
        alarmNoticeTableView.rx.modelSelected(AlarmTableViewCell.self)
            .subscribe(onNext: { [weak self] in
                $0.noticeIsRead()
                let hasLinkToSafari = $0.hasOutboundLink()
                let answerId = $0.getAnswerId()
                
                if hasLinkToSafari != false {
                    // 외부 링크로 나가기
                }
                
                if let answerId = answerId {
                    if answerId == -1 {
                        // 나의 서재로 넘어가기
                        // self?.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
                    } else {
                        // answerId 를 가지고 answer 화면으로 넘어가기
                        // self?.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
                    }
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
}
