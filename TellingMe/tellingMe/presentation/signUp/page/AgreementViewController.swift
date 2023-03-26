//
//  AgreementViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

protocol SendButtonClicked {
    func isAgreementChecked(data: Bool)
    func isNameTyped(data: Bool)
    func isGenderSelected(data: Bool)
    func isBirthdaySelected(data: Bool)
}

class AgreementViewController: UIViewController {

    @IBOutlet weak var agreementButton: UIButton!
    var delegate : SendButtonClicked?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func toggleAgreement(_ sender: UIButton) {
        delegate?.isChecked(data: agreementButton.isSelected)
    }
}
