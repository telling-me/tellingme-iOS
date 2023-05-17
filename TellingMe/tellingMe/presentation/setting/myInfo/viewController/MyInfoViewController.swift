//
//  MyInfoViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit

class MyInfoViewController: DropDownViewController {
    @IBOutlet weak var headerView: SettingHeaderView!
    @IBOutlet weak var mbtiButton: DropDownButton!
    @IBOutlet weak var yearButton: DropDownButton!
    @IBOutlet weak var monthButton: DropDownButton!
    @IBOutlet weak var dayButton: DropDownButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.setTitle(title: "내 정보 수정하기")
        headerView.delegate = self
        mbtiButton.delegate = self
        yearButton.delegate = self
        dayButton.delegate = self

        mbtiButton.setLayout()
        mbtiButton.setTitle(text: "mbti선택", isSmall: false)
        yearButton.setMediumLayout()
        yearButton.setTitle(text: "년", isSmall: false)
        yearButton.setMediumLayout()
        yearButton.setTitle(text: "월", isSmall: false)
        dayButton.setMediumLayout()
        dayButton.setTitle(text: "일", isSmall: false)
    }

}

extension MyInfoViewController: SettingHeaderViewDelegate {
    func popViewController(_ headerView: SettingHeaderView) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyInfoViewController: DropDownButtonDelegate {
    func showDropDown(_ button: DropDownButton) {
        switch button.tag {
        case 0:
            items =
        case 1:
            items =
        case 2:
            items =
        case 3:
            items = 
        }
        
        print(button)
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)

        tableView.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 208).isActive = true
    }
}
