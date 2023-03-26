//
//  AgreementViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class AgreementViewController: UIViewController {

    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func toggleAgreement(_ sender: UIButton) {
        if sender.isSelected {
            nextButton.isEnabled = false
            sender.isSelected = false
        } else {
            nextButton.isEnabled = true
            sender.isSelected = true
        }
    }

    @IBAction func clickNextButton(_ sender: UIButton) {
        print("눌리긴햇지")
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "getName") else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
