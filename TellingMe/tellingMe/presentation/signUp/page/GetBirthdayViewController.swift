//
//  GetBirthViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

struct Birth {
    var year: Int?
    var month: Int?
    var day: Int?
}

class GetBirthdayViewController: UIViewController {
    @IBOutlet weak var yearTableView: UITableView!
    @IBOutlet weak var monthTableView: UITableView!
    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var dayView: UIView!
    var myBirth: Birth = Birth()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setEnabled() {
        if let year = myBirth.year {
            monthView.isUserInteractionEnabled = true
            if let month = myBirth.month {
                dayView.isUserInteractionEnabled = true
            } else {
                dayView.isUserInteractionEnabled = false
            }
        } else {
            monthView.isUserInteractionEnabled = false
            dayView.isUserInteractionEnabled = false
        }
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 2)
    }
}

extension GetBirthdayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == yearTableView {
            return 100
        } else if tableView == monthTableView {
            return 12
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == yearTableView {
            return UITableViewCell()
        } else if tableView == monthTableView {
            return UITableViewCell()
        } else {
             return UITableViewCell()
        }
    }
}
