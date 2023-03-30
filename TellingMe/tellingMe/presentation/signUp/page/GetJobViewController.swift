//
//  GetJobViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class GetJobViewController: UIViewController {

    let jobs: [String] = ["고등학생", "대학(원)생", "취업준비생", "직장인", "주부", "기타"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension GetJobViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
