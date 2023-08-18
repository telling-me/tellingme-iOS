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

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.096, green: 0.096, blue: 0.096, alpha: 0.28)
    }

    override func viewWillDisappear(_ animated: Bool) {
        view.backgroundColor = .clear
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
