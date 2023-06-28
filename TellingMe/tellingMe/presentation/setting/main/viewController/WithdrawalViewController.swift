//
//  Withdrawal ViewController.swift
//  tellingMe
//
//  Created by 마경미 on 02.06.23.
//

import UIKit

class WithdrawalViewController: SettingViewController {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var withdrawalButton: SecondaryTextButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButton.setImage(UIImage(systemName: "checkmark"), for: .selected)
        withdrawalButton.isEnabled = false
        headerView.setTitle(title: "회원 탈퇴")
    }

    @IBAction func clickAgree(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            // agree
            withdrawalButton.isEnabled = true

        } else {
            // not agree
            withdrawalButton.isEnabled = false
        }
    }

    @IBAction func clickWithdrawal(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "withdrawalModal") as? ModalViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension WithdrawalViewController: ModalActionDelegate {
    func clickCancel() {
    }

    func clickOk() {
        withDrawalUser()
    }
}
