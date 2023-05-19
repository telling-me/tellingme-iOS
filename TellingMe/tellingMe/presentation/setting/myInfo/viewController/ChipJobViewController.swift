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
    var selectedItem: Int? = nil
    var keyboardSize: CGSize? = nil

    let input = Input()

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
    }
}

extension ChipJobViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.row
        input.setDisalbe()
        if let parentViewController = self.parent as? MyInfoViewController {
            parentViewController.viewModel.job = self.selectedItem
        }

        if indexPath.row == jobs.count - 1 {
            input.setAble()
        }
    }
}

extension ChipJobViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        input.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let parentViewController = self.parent as? MyInfoViewController {
            parentViewController.viewModel.jobInfo = text
        }
    }
}
