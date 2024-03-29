//
//  JobViewController.swift
//  tellingMe
//
//  Created by 마경미 on 15.05.23.
//

import UIKit

class ChipJobViewController: ChipCollectionViewController {
    let jobs: [String] = ["고등학생", "대학(원)생", "취업준비생", "직장인", "주부", "기타"]
    var jobInfo: String? = nil
    var selectedItem: Int = 0
    var keyboardSize: CGSize? = nil

    let input = CustomTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setItems(items: jobs)
        view.addSubview(input)
        input.translatesAutoresizingMaskIntoConstraints = false
        input.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170).isActive = true
        input.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        input.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        input.heightAnchor.constraint(equalToConstant: 57).isActive = true
        input.setDisalbe()
        input.inputTextField.delegate = self
    }
}

extension ChipJobViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.row
        input.setDisalbe()
        if let parentViewController = self.parent as? MyInfoViewController {
            parentViewController.viewModel.job = self.selectedItem
            parentViewController.viewModel.jobInfo = nil
        }

        if indexPath.row == jobs.count - 1 {
            input.setAble()
        }
    }
}

extension ChipJobViewController: UITextFieldDelegate {    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let parentViewController = self.parent as? MyInfoViewController {
            parentViewController.viewModel.jobInfo = text
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        input.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let parentViewController = self.parent as? MyInfoViewController {
            parentViewController.viewModel.jobInfo = text
            parentViewController.isAllSelected()
        }
    }
}
