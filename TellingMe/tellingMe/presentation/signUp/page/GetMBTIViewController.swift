//
//  GetMBTIViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class GetMBTIViewController: UIViewController {
    @IBOutlet weak var mbtiButton: DropDownButton!
    @IBOutlet weak var prevButton: SecondayIconButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var mbtiTableView: UITableView!
    @IBOutlet weak var mbtiHeight: NSLayoutConstraint!
    let viewModel = GetMBTIViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        mbtiButton.setLayout()
        mbtiButton.setTitle(text: "mbti 선택", isSmall: false)
        prevButton.setImage(image: "ArrowLeft")
        setAction()
    }

    func setAction() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        mbtiButton.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc
    func didTapView(_ sender: UITapGestureRecognizer) {
        if mbtiTableView.isHidden {
            self.mbtiTableView.isHidden = false
            UIView.transition(with: self.mbtiTableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.mbtiHeight.constant = 208
            })
        } else {
            self.mbtiHeight.constant = 0
            self.mbtiTableView.isHidden = true
        }
    }

    @IBAction func pushAllowNotification(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "allowNotification")as? AllowNotificationViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

        SignUpData.shared.mbti = viewModel.myMbti
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPage()
    }
}

extension GetMBTIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.id) as? DropDownTableViewCell else { return UITableViewCell() }
        cell.setCell(text: viewModel.mbtis[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DropDownTableViewCell else { return }
        tableView.isHidden = true
        mbtiButton.setTitle(text: cell.getCell(), isSmall: false)
        viewModel.myMbti = cell.getCell()
        completeButton.isEnabled = true
    }
}
