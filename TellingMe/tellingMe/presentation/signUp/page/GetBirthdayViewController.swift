//
//  GetBirthViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class GetBirthdayViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        print(pageViewController)
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 2)
    }
}
