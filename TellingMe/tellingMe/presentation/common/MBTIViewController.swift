//
//  MBTIViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit

class MBTIViewController: DropDownViewController {
    let viewModel = MBTIViewModel()

    let mbtiButton: DropDownButton = {
        let view = DropDownButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setLayout()
        view.setTitle(text: "mbti 선택", isSmall: false)
        return view
    }()

    func setAction() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        mbtiButton.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc
    func didTapView(_ sender: UITapGestureRecognizer) {
        if self.tableView.isHidden {
            self.tableView.isHidden = false
            UIView.transition(with: self.tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.setOpenHeight()
            })
        } else {
            self.setOriginalHeight()
            self.tableView.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        items = viewModel.mbtis
        height = 52

        view.addSubview(mbtiButton)
        mbtiButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mbtiButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mbtiButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mbtiButton.heightAnchor.constraint(equalToConstant: 57).isActive = true

        setAction()
    }
}

extension MBTIViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DropDownTableViewCell else { return }
        tableView.isHidden = true
        mbtiButton.setTitle(text: cell.getCell(), isSmall: false)
        viewModel.myMbti = cell.getCell()
    }
}
