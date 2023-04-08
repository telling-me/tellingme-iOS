//
//  GetMBTIViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class GetMBTIViewController: UIViewController {
    @IBOutlet weak var mbtiButton: DropDownButton!
    @IBOutlet weak var mbtiTableView: UITableView!
    @IBOutlet weak var mbtiHeight: NSLayoutConstraint!
    var myMbti: String?
    let mbtis: [String] = ["ENFJ", "ENFP", "ENTJ", "ENTP", "ESFJ", "ESFP", "ESTJ", "ESTP", "INFJ", "INFP", "INTJ", "INTP", "ISFJ", "ISFP", "ESTJ", "ESTP"]

    override func viewDidLoad() {
        super.viewDidLoad()
        mbtiButton.setLayout()
        mbtiButton.setTitle(text: "mbti 선택")
        setButton()
    }

    func setButton() {
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

    func sendSignUpData() {
        let request = SignUpRequest(allowNotification: SignUpData.shared.allowNotification, nickname: SignUpData.shared.nickname, purpose: SignUpData.shared.purpose, job: SignUpData.shared.job, gender: SignUpData.shared.gender, birthData: SignUpData.shared.birthData ?? nil, mbti: SignUpData.shared.mbti, socialId: KeychainManager.shared.load(key: "socialId") ?? "", socialLoginType: KeychainManager.shared.load(key: "socialLoginType") ?? "")
        SignAPI.postSignUp(request: request) { result in
            switch result {
            case .success(let response):
                print("success야", response)
            case .failure(let error):
                print("error야", error)
            }
        }
    }

    @IBAction func nextAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)

        SignUpData.shared.mbti = myMbti
        sendSignUpData()
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 5)
    }
}

extension GetMBTIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.id) as? DropDownTableViewCell else { return UITableViewCell() }
        cell.setCell(text: mbtis[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DropDownTableViewCell else { return }
        tableView.isHidden = true
        mbtiButton.setTitle(text: cell.getCell())
        myMbti = cell.getCell()
    }
}
