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
        bindViewModel()
        setLayout()
        setStyles()
    }
}

extension JobViewController {
    private func bindViewModel() {
        viewModel.jobs
            .bind(to: jobTableView.rx.items(cellIdentifier: JobTableViewCell.id, cellType: JobTableViewCell.self)) { row, data, cell in
                cell.setData(with: data)
            }
            .disposed(by: disposeBag)
        jobTableView.rx.itemSelected
            .bind(to: viewModel.selectedJobIndex)
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubview(jobTableView)
        
        jobTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(60)
            $0.bottom.equalTo(view.keyboardLayoutGuide)
        }
    }
    
    private func setStyles() {
        titleLabel.do {
            $0.text = "직업을 알려주세요"
        }
        
        infoButton.do {
            $0.isHidden = false
        }
        
        jobTableView.do {
            $0.delegate = self
            $0.separatorStyle = .none
            $0.register(JobTableViewCell.self, forCellReuseIdentifier: JobTableViewCell.id)
        }
    }
}

extension JobViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let rowHeight = (tableView.frame.height - 65 - 12 * 5) / 6
//        return rowHeight
        return 67
    }
}
