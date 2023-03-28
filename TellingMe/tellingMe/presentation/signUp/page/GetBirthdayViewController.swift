//
//  GetBirthViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class GetBirthdayViewController: UIViewController {
    @IBOutlet weak var birthdayPicker: UIDatePicker!

    let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary400main")
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func datePciekrChanged(_ sender: UIDatePicker) {
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 2)
    }
}
