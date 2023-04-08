//
//  GetJobViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class GetJobViewController: UIViewController {
    let jobs: [JobViewModel] = [JobViewModel(title: "고등학생", imgName: "HighSchool"), JobViewModel(title: "대학(원)생", imgName: "University"), JobViewModel(title: "취업준비생", imgName: ""), JobViewModel(title: "직장인", imgName: "Worker"), JobViewModel(title: "주부", imgName: ""), JobViewModel(title: "기타", imgName: "Heart")]
    var selecteItem: Int? = nil
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPageWithIndex(index: 4)
        if let selecteItem = selecteItem {
            SignUpData.shared.job = selecteItem
        }
    }
    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 2)
        self.dismiss(animated: true, completion: nil)
    }
}

extension GetJobViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.id, for: indexPath) as? JobTableViewCell else { return UITableViewCell() }
        cell.setData(with: jobs[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == jobs.count - 1 {
            guard let cell = tableView.cellForRow(at: indexPath) as? JobTableViewCell else { return }
            UIView.animate(withDuration: 0.2, animations: {
                cell.frame.size = CGSize(width: cell.frame.width, height: 114)
            })
            cell.setEnabledTextField()
        }
        self.nextButton.isEnabled = true
        self.selecteItem = indexPath.row
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.row == jobs.count - 1 {
            guard let cell = tableView.cellForRow(at: indexPath) as? JobTableViewCell else { return }
            cell.frame.size = CGSize(width: cell.frame.width, height: 67)
            cell.setDisabledTextField()
        }
    }
}
