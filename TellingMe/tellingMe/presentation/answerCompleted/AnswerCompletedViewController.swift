//
//  AnswerCompletedViewController.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import UIKit

class AnswerCompletedViewController: PullDownViewController {
    let viewModel = AnswerCompletedViewModel()
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var emotionLabel: Body2Bold!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var mainQuestionLabel: Body1Bold!
    @IBOutlet weak var subQuestionLabel: Body2Regular!
    @IBOutlet weak var dayLabel: CaptionLabelRegular!
    @IBOutlet weak var countTextLabel: CaptionLabelBold!
    @IBOutlet weak var answerTextView: UITextView!

    override func viewWillAppear(_ animated: Bool) {
        getQuestion()
        getAnswer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        items = viewModel.menus
        tableView.reloadData()
    }

    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickMenu(_ sender: UIButton) {
        if tableView.isHidden {
            view.addSubview(tableView)
            tableView.isHidden = false
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            tableView.widthAnchor.constraint(equalToConstant: 66).isActive = true
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(viewModel.menus.count * 40)).isActive = true
            tableView.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 4).isActive = true
        } else {
            tableView.removeFromSuperview()
            tableView.isHidden = true
        }
    }

    func setQuestionDate(date: String) {
        self.viewModel.questionDate = date
    }
}

extension AnswerCompletedViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // 수정 viewcontroller push
            let storyboard = UIStoryboard(name: "Answer", bundle: nil)
            guard let vc = storyboard.instantiateViewController(identifier: "modifyAnswer") as? ModifyAnswerViewController else {
                return
            }
            vc.setQuestionDate(date: self.viewModel.questionDate!)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // 삭제 modal viewcontroller present
            let storyboard = UIStoryboard(name: "Modal", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "modalDeleteAnswer") as? ModalViewController else { return }
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
        tableView.isHidden = true
        tableView.removeFromSuperview()
    }
}

extension AnswerCompletedViewController: ModalActionDelegate {
    func clickCancel() {
    }

    func clickOk() {
        self.deleteAnswer()
        self.navigationController?.popViewController(animated: true)
    }
}
