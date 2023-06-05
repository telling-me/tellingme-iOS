//
//  ModalViewController.swift
//  tellingMe
//
//  Created by 마경미 on 21.05.23.
//

import UIKit

protocol ModalActionDelegate: AnyObject {
    func clickCancel()
    func clickOk()
}

class ModalViewController: UIViewController {
    weak var delegate: ModalActionDelegate?
    @IBOutlet weak var cancelButton: TeritaryTextButton!
    @IBOutlet weak var okButton: SecondaryTextButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func clickButton(_ sender: UIButton) {
        // 취소 버튼 tag = 0, else = 1
        if sender.tag == 0 {
            self.dismiss(animated: true)
            self.delegate?.clickCancel()
        } else {
            self.dismiss(animated: true)
            self.delegate?.clickOk()
        }
    }
}