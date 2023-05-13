//
//  DropDownViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit

class DropDownViewController: UIViewController {
    var items: [String] = []
    var height: CGFloat = 0
    var tableViewTopConstraint = NSLayoutConstraint()
    var tableViewLeadingConstraint = NSLayoutConstraint()
    var tableViewTrailingConstraint = NSLayoutConstraint()
    var talbeViewBttomConstraint = NSLayoutConstraint()
    var tableViewWidthConstraint = NSLayoutConstraint()
    var tableViewHeightConstraint = NSLayoutConstraint()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.clipsToBounds = true
        tableView.cornerRadius = 18
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        
        updateTableViewLayout(leading: 0, trailing: 0, top: 0, height: 0)
    }
    
    func updateTableViewLayout(leading: CGFloat, trailing: CGFloat, top: CGFloat, height: CGFloat) {
        tableViewTopConstraint.isActive = false
        tableViewLeadingConstraint.isActive = false
        tableViewTrailingConstraint.isActive = false
        talbeViewBttomConstraint.isActive = false
        tableViewWidthConstraint.isActive = false
        tableViewHeightConstraint.isActive = false
        
        tableViewLeadingConstraint = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading)
        tableViewTrailingConstraint = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
        tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: top)
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: height)
        
        tableViewLeadingConstraint.isActive = true
        tableViewTrailingConstraint.isActive = true
        tableViewTopConstraint.isActive = true
        tableViewHeightConstraint.isActive = true
    }

    func setOpenHeight() {
        tableViewHeightConstraint.isActive = false
        tableView.heightAnchor.constraint(equalToConstant: 208).isActive = true
    }

    func setOriginalHeight() {
        tableViewHeightConstraint.isActive = false
        tableView.heightAnchor.constraint(equalToConstant: 0).isActive = true
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
        return height
    }
}
