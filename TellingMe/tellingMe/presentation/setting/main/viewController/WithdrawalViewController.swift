//
//  Withdrawal ViewController.swift
//  tellingMe
//
//  Created by 마경미 on 02.06.23.
//

import UIKit

class WithdrawalViewController: SettingViewController {

    @IBOutlet weak var withdrawalButton: SecondaryTextButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.setTitle(title: "회원 탈퇴")
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
