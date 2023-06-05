//
//  SettingTableViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit

class SettingTableViewController: UITableViewController {
    let viewModel = SettingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let count = viewModel.itemsCount else { return }
        print(indexPath.row)
        if indexPath.row == 0 {
            print("여기?")
        } else if indexPath.row == 5 {
            self.signout()
        } else {
            print("모지?")
            let id = viewModel.items[indexPath.row-1].id
            let viewController = viewModel.items[indexPath.row-1].view
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: id) ?? viewController as? UIViewController else {
                return
            }
            print("거지같다")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}