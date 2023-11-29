//
//  JobViewController.swift
//  tellingMe
//
//  Created by 마경미 on 02.10.23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class JobViewController: SignUpBaseViewController {
    private let viewModel: SignUpViewModel
    private let disposeBag = DisposeBag()
    
    private let jobTableView = UITableView()
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.checkJobSelected(nil)
    }

    override func bindViewModel() {
        infoButton.rx.tap
            .bind(to: viewModel.showInfoSubject)
            .disposed(by: disposeBag)
        
        jobTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.jobs
            .bind(to: jobTableView.rx.items(cellIdentifier: JobTableViewCell.id, cellType: JobTableViewCell.self)) { [self] row, data, cell in
                cell.setData(with: data)
                if row == self.viewModel.jobCount - 1 {
                    cell.textObservable
                        .bind(to: self.viewModel.jobetcTextRelay)
                        .disposed(by: disposeBag)
                }
            }
            .disposed(by: disposeBag)
        
        jobTableView.rx.itemSelected
            .bind(onNext: { [weak self] indexPath in
                guard let self else { return }
                viewModel.checkJobSelected(indexPath)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.showJobEtcSubject
            .bind(onNext: {[weak self] isShow in
                guard let self else { return }
                toggleEtcInputBox(isShow: isShow)
            })
            .disposed(by: disposeBag)
    }
    
    override func setStyles() {
        titleLabel.do {
            $0.text = "직업을 알려주세요"
        }
        
        infoButton.do {
            $0.isHidden = false
        }
        
        jobTableView.do {
            $0.backgroundColor = .Side100
            $0.separatorStyle = .none
            $0.register(JobTableViewCell.self, forCellReuseIdentifier: JobTableViewCell.id)
        }
    }
    
    override func setLayout() {
        view.addSubview(jobTableView)
        
        jobTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(60)
            $0.bottom.equalTo(view.keyboardLayoutGuide)
        }
    }
    
    deinit {
        print("JobViewController Deinited")
    }
}

extension JobViewController {
    private func toggleEtcInputBox(isShow: Bool) {
        guard let cell = jobTableView.cellForRow(at: IndexPath(row: viewModel.jobCount - 1, section: 0)) as? JobTableViewCell else {
            return
        }

        if isShow {
            cell.frame.size = CGSize(width: cell.frame.width, height: 104)
            cell.showEtcInputBox()
        } else {
            cell.frame.size = CGSize(width: cell.frame.width, height: 67)
            cell.hiddenEtcInputBox()
        }
    }
}

extension JobViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
}
