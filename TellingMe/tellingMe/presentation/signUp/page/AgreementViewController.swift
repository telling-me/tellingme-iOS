//
//  AgreementViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class AgreementViewController: UIViewController {
    @IBOutlet weak var agreementButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func toggleAgreement(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPageWithIndex(index: 1)
    }
}
