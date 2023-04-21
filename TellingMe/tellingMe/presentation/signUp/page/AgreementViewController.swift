//
//  AgreementViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class AgreementViewController: UIViewController {
    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var nextButton: SecondayIconButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        agreementButton.setImage(UIImage(systemName: ""), for: .disabled)
        agreementButton.setImage(UIImage(systemName: "checkmark"), for: .selected)
        agreementButton.setImage(UIImage(), for: .normal)
        nextButton.isEnabled = false
        nextButton.setImage(image: "ArrowRight")
    }

    @IBAction func toggleAgreement(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            nextButton.isEnabled = false
        } else {
            sender.isSelected = true
            nextButton.isEnabled = true
        }
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPage()
    }
}
