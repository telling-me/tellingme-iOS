//
//  MyInfoViewController+.swift
//  tellingMe
//
//  Created by 마경미 on 12.06.23.
//

import Foundation
import UIKit

extension MyInfoViewController: SettingHeaderViewDelegate {
    func popViewController(_ headerView: SettingHeaderView) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyInfoViewController: DropDownButtonDelegate {
    func showDropDown(_ button: DropDownButton) {
        viewModel.currentTag = button.tag
        switch button.tag {
        case 0:
            guard let array = viewModel.yearArray else { return }
            items = array.map { String($0) }
        case 1:
            items = viewModel.monthArray.map { String($0) }
        case 2:
            items = viewModel.dayArray.map { String($0) }
        case 3:
            items = viewModel.mbtis
        default:
            break
        }

        if tableView.isHidden {
            button.setOpen()
            view.addSubview(tableView)
            tableView.isHidden.toggle()
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8),
                tableView.heightAnchor.constraint(equalToConstant: 208)
            ])
        } else {
            button.setClose()
            tableView.isHidden.toggle()
            tableView.removeFromSuperview()
        }
        tableView.reloadData()
    }
}

extension MyInfoViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let yearArray = viewModel.yearArray else { return }
        switch viewModel.currentTag {
        case 0:
            viewModel.year = yearArray[indexPath.row]
            yearButton.setClose()
            yearButton.setTitle(text: viewModel.year!, isSmall: false)
        case 3:
            viewModel.mbti = viewModel.mbtis[indexPath.row]
            mbtiButton.setClose()
            mbtiButton.setTitle(text: viewModel.mbti!, isSmall: false)
        default:
            fatalError("currentTag 설정 해주세요")
        }
        tableView.isHidden = true
        tableView.removeFromSuperview()
    }
}

extension MyInfoViewController: SendNicknameDelegate {
    func nicknameisEmpty() {
        self.completedButton.isEnabled = false
    }

    func nicknameisNotEmpty() {
        self.completedButton.isEnabled = true
        self.viewModel.nickname = nickNameVC.getText()!
    }
}

extension MyInfoViewController: ModalActionDelegate {
    func clickCancel() {
    }

    func clickOk() {
        updateUserInfo()
    }
}
