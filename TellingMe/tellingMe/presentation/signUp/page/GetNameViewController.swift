//
//  GetNameViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class GetNameViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPageWithIndex(index: 2)
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 0)
    }
}
