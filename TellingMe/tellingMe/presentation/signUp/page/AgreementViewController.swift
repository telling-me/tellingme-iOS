//
//  AgreementViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class AgreementViewController: UIViewController {
    @IBOutlet weak var agreement2: UIButton!
    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var nextButton: SecondaryIconButton!
    @IBOutlet weak var agreement1: UIButton!

    var isAgreement1 = false
    var isAgreement2 = false

    override func viewWillAppear(_ animated: Bool) {
        if isAgreement1 {
            agreement1.isSelected = true
        } else if isAgreement2 {
            agreement2.isSelected = true
        }
        if isAgreement1 && isAgreement2 {
                agreementButton.isSelected = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agreementButton.setImage(UIImage(systemName: ""), for: .normal)
        agreementButton.setImage(UIImage(systemName: "checkmark"), for: .selected)
        agreement1.setImage(UIImage(systemName: ""), for: .normal)
        agreement1.setImage(UIImage(systemName: "checkmark"), for: .selected)
        agreement2.setImage(UIImage(systemName: ""), for: .normal)
        agreement2.setImage(UIImage(systemName: "checkmark"), for: .selected)
        agreementButton.setImage(UIImage(), for: .normal)
        nextButton.isEnabled = false
        nextButton.setImage(image: "ArrowRight")
    }

    @IBAction func toggleAgreement(_ sender: UIButton) {
        if sender == agreementButton {
            agreementButton.isSelected.toggle()
            isAgreement1.toggle()
            isAgreement2.toggle()
            agreement1.isSelected = isAgreement1
            agreement2.isSelected = isAgreement2
        } else if sender == agreement1 {
            isAgreement1.toggle()
            agreement1.isSelected = isAgreement1
            if isAgreement1 && isAgreement2 {
                agreementButton.isSelected = true
            } else {
                agreementButton.isSelected = false
            }
        } else {
            isAgreement2.toggle()
            agreement2.isSelected = isAgreement2
            if isAgreement1 && isAgreement2 {
                agreementButton.isSelected = true
            } else {
                agreementButton.isSelected = false
            }
        }

        if agreementButton.isSelected {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }

    @IBAction func popUp(_ sender: UIButton) {
        if sender.tag == 0 {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "agreement1") as? AgreementDetailViewController1 else {
                return
            }
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        } else {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "agreement2") as? AgreementDetailViewController2 else {
                return
            }
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPage()
    }
}
