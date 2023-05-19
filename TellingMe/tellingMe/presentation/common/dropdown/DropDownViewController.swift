//
//  DropDownViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit

class DropDownViewController: UIViewController {
    var items: [String] = []
    var rowHeight: CGFloat = 52

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.clipsToBounds = true
        tableView.cornerRadius = 18
        tableView.bounces = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        tableView.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.id)
    }
}

extension DropDownViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.id) as? DropDownTableViewCell else { return UITableViewCell() }
        cell.setCell(text: items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}
