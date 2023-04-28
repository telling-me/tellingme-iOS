//
//  GetJobViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class GetJobViewController: UIViewController {
    @IBOutlet weak var prevButton: SecondayIconButton!
    @IBOutlet weak var nextButton: SecondayIconButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    let viewModel = GetJobViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.setImage(image: "ArrowLeft")
        nextButton.isEnabled = false
        nextButton.setImage(image: "ArrowRight")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.offKeyboard()
    }

    func offKeyboard() {
        guard let text = viewModel.input.text else { nextButton.isEnabled = false
            return
        }
        if text.count <= 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        viewModel.input.resignFirstResponder()
    }

    func setDisabledTextField() {
        viewModel.input.removeFromSuperview()
    }

    func setEnabledTextField(cell: UITableViewCell) {
        guard let cell = cell as? JobTableViewCell else { return }
        viewModel.input.delegate = self
        cell.cellView.addSubview(viewModel.input)

        viewModel.input.leadingAnchor.constraint(equalTo: cell.cellView.leadingAnchor, constant: 24).isActive = true
        viewModel.input.trailingAnchor.constraint(equalTo: cell.cellView.trailingAnchor, constant: -24).isActive = true
        viewModel.input.bottomAnchor.constraint(equalTo: cell.cellView.bottomAnchor, constant: -18).isActive = true
    }

    @objc func keyboardWillShow(notification: Notification) {
        containerViewTopConstraint.isActive = false
        containerViewTopConstraint = containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -245)
        containerViewTopConstraint.isActive = true
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        containerViewTopConstraint.isActive = false
        containerViewTopConstraint = containerView.topAnchor.constraint(equalTo: view.topAnchor)
        containerViewTopConstraint.isActive = true
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func nextAction(_ sender: UIButton) {
        guard let text = viewModel.input.text else { return }
        if let selecteItem = viewModel.selecteItem {
            SignUpData.shared.job = selecteItem
            if selecteItem == 5 {
                self.postJobInfo(job: text)
                SignUpData.shared.jobInfo = text
            } else {
                let pageViewController = self.parent as? SignUpPageViewController
                pageViewController?.nextPage()
            }
        }
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPage()
    }
}

extension GetJobViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jobsCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.id, for: indexPath) as? JobTableViewCell else { return UITableViewCell() }
        cell.setData(with: viewModel.jobs[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.jobsCount ?? 0) - 1 {
            guard let cell = tableView.cellForRow(at: indexPath) as? JobTableViewCell else { return }
            UIView.animate(withDuration: 0.2, animations: {
                cell.frame.size = CGSize(width: cell.frame.width, height: 114)
            })
            self.setEnabledTextField(cell: cell)
        } else {
            self.nextButton.isEnabled = true
        }
        viewModel.selecteItem = indexPath.row
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.jobsCount ?? 0) - 1 {
            guard let cell = tableView.cellForRow(at: indexPath) as? JobTableViewCell else { return }
            cell.frame.size = CGSize(width: cell.frame.width, height: 67)
            self.setDisabledTextField()
        }
    }
}

extension GetJobViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        if text.count > 0 {
            self.nextButton.isEnabled = true
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.offKeyboard()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         let indexPath = IndexPath(row: 0, section: 0)
         tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
