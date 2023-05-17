//
//  SettingViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var headerView: SettingHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.setTitle(title: "설정")
        headerView.delegate = self
    }

}

extension SettingViewController: SettingHeaderViewDelegate {
    func popViewController(_ headerView: SettingHeaderView) {
        self.navigationController?.popViewController(animated: true)
    }
}
