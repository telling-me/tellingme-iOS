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
    private let indicatorView = UIActivityIndicatorView(style: .large)
    
    private var disposeBag = DisposeBag()
    private let viewModel = AlarmNoticeViewModel()
    private lazy var isNoticeAllRead: BehaviorRelay<Bool> = viewModel.outputs.isAlarmAllRead
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
                self?.loadingStarts()
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self?.viewModel.fetchNoticeData()
                    self?.loadingStops()
                }
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
                let link: String? = cell.getLinkString()
                let noticeId = cell.getNoticeId()
                let datePublished = cell.getDateString()
                
                self?.viewModel.inputs.readNotice(idOf: noticeId)
                                
                if hasLinkToSafari != false {
                    self?.viewModel.inputs.openSafariWithUrl(url: link)
                }

                if let answerId = answerId {
                    if answerId == -1 {
                        print("✅ The AnswerId is -1.")
                        let vc = LibraryViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        print("✅ The AnswerId is not -1.")
                        let vc = DetailAnswerViewController()
                        vc.setData(answerId: answerId, datePublished: datePublished)
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        alarmNoticeTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                do {
                    guard let cell = self?.alarmNoticeTableView.cellForRow(at: indexPath) as? AlarmTableViewCell else { return }
                    let noticeId = cell.getNoticeId()
                    var newData: [AlarmNotificationResponse] = []
                    guard let dataChanged = try self?.viewModel.outputs.alarmNotices.value() else { return }
                    newData = dataChanged
                    newData.remove(at: indexPath.row)
                    self?.viewModel.inputs.deleteNotice(idOf: noticeId)
                    self?.viewModel.outputs.alarmNotices.onNext(newData)
                } catch let error {
                    print(error)
                }
            })
            .disposed(by: disposeBag)
        
        isNoticeAllRead
            .asDriver()
            .drive { [weak self] bool in
                self?.alarmSectionView.isAllNoticeRead(bool)
            }
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
        
        indicatorView.do {
            $0.color = .Logo
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

extension AlarmViewController {
    private func loadingStarts() {
        view.addSubview(indicatorView)
        
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        indicatorView.startAnimating()
    }
    
    private func loadingStops() {
        indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
    }
}
