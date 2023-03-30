//
//  MBTITableViewController.swift
//  tellingMe
//
//  Created by 마경미 on 30.03.23.
//

import UIKit

class MBTITableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath)
//        let cell = tableView.cellForRow(at: indexPath)
//        let view = UIView()
//        view.backgroundColor = UIColor.blue
//        cell?.selectedBackgroundView = view
//    }
}
