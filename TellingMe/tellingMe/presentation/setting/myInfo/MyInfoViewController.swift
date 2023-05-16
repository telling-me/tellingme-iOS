//
//  MyInfoViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit

class MyInfoViewController: UIViewController {
    @IBOutlet weak var headerView: SettingHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.setTitle(title: "내 정보 수정하기")
        headerView.delegate = self
    }

}

extension MyInfoViewController: SettingHeaderViewDelegate {
    func popViewController(_ headerView: SettingHeaderView) {
        self.navigationController?.popViewController(animated: true)
    }
}
