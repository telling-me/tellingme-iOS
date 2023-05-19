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

    let viewModel = MyInfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.setTitle(title: "내 정보 수정하기")
        headerView.delegate = self
        mbtiButton.delegate = self
        yearButton.delegate = self
        monthButton.delegate = self
        dayButton.delegate = self

        mbtiButton.setLayout()
        mbtiButton.setTitle(text: "mbti선택", isSmall: false)
        yearButton.setMediumLayout()
        yearButton.setTitle(text: "년", isSmall: false)
        monthButton.setMediumLayout()
        monthButton.setTitle(text: "월", isSmall: false)
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
            view.addSubview(tableView)
            tableView.isHidden.toggle()
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8),
                tableView.heightAnchor.constraint(equalToConstant: 208)
            ])
        } else {
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
            yearButton.setTitle(text: viewModel.year!, isSmall: false)
        case 1:
            viewModel.month = viewModel.monthArray[indexPath.row]
            monthButton.setTitle(text: viewModel.month!, isSmall: false)
        case 2:
            viewModel.day = viewModel.dayArray[indexPath.row]
            dayButton.setTitle(text: viewModel.day!, isSmall: false)
        case 3:
            viewModel.mbti = viewModel.mbtis[indexPath.row]
            mbtiButton.setTitle(text: viewModel.mbti!, isSmall: false)
        default:
            fatalError("currentTag 설정 해주세요")
        }
        tableView.isHidden = true
        tableView.removeFromSuperview()
    }
}
