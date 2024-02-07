//
//  AlertViewController.swift
//  tellingMe
//
//  Created by 마경미 on 14.08.23.
//

import Foundation
import UIKit

protocol AlertActionDelegate: AnyObject {
    func clickOk()
}

class AlertViewController: UIViewController {
    weak var delegate: AlertActionDelegate?

    var labeltext = ""
    @IBOutlet weak var okButton: SecondaryTextButton!
    @IBOutlet weak var label: Body1Regular!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labeltext
    }

    func setLabel(text: String) {
        labeltext = text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.backgroundColor = .clear
    }
    
    @IBAction func clickOkButton(_ sender: SecondaryTextButton) {
        self.dismiss(animated: true)
        delegate?.clickOk()
    }
}
