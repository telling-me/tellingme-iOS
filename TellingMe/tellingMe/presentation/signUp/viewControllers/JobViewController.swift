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

struct Job {
    let title: String
    let imgName: String
}

class JobViewController: SignUpBaseViewController {
    let jobs: Observable<[Job]> = Observable.just([
        Job(title: "중·고등학생", imgName: "HighSchool"),
        Job(title: "대학(원)생", imgName: "University"),
        Job(title: "취업준비생", imgName: "Jobseeker"),
        Job(title: "직장인", imgName: "Worker"),
        Job(title: "주부", imgName: "Housewife"),
        Job(title: "기타", imgName: "Etc")
    ])
    let selectedItem = BehaviorRelay(value: IndexPath(row: 0, section: 0))
    let etc = BehaviorRelay(value: "")

    private let disposeBag = DisposeBag()
    
    private let jobTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
        setStyles()
    }
}

extension JobViewController {
    private func bindViewModel() {
        jobs
            .bind(to: jobTableView.rx.items(cellIdentifier: JobTableViewCell.id, cellType: JobTableViewCell.self)) { row, data, cell in
                cell.setData(with: data)
            }
            .disposed(by: disposeBag)
        jobTableView.rx.itemSelected
            .bind(to: selectedItem)
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
