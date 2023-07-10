//
//  ListTableViewController.swift
//  tellingMe
//
//  Created by 마경미 on 04.07.23.
//

import UIKit

class ListTableViewController: UITableViewController {
    static let id = "listTableViewController"
    var answerList: [AnswerListResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 74
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerListTableViewCell.id) as? AnswerListTableViewCell else { return UITableViewCell() }
        cell.setCell(data: answerList[indexPath.row])
            return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let selectedCell = tableView.cellForRow(at: indexPath) as? AnswerListTableViewCell else { return }
            let storyboard = UIStoryboard(name: "AnswerCompleted", bundle: nil)
            guard let vc = storyboard.instantiateViewController(identifier: "answerCompleted") as? AnswerCompletedViewController else {
                return
            }
            vc.setQuestionDate(date: (selectedCell.date?.intArraytoDate())!)
            self.navigationController?.pushViewController(vc, animated: true)
    }
}
