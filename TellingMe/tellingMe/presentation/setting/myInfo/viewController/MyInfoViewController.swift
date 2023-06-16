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

    @IBOutlet var containerViews: [UIView]!
    let viewModel = MyInfoViewModel()
    let nickNameVC = NickNameInputViewController()
    let purposeVC = ChipPurposeViewController()
    let jobVC = ChipJobViewController()
    let genderVC = ChipGenderViewController()

    let completedButton: UIButton = {
       let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFB", size: 15)
        button.setTitleColor(UIColor(named: "Gray2"), for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(named: "Logo"), for: .normal)
        return button
    }()

    func setInitLayout() {
        let viewControllers = [nickNameVC, purposeVC, jobVC, genderVC]
        for (index, view) in containerViews.enumerated() {
            let viewController = viewControllers[index]
            view.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            addChild(viewController)
            viewController.didMove(toParent: self)
        }

        nickNameVC.setText(text: viewModel.nickname)
        purposeVC.setSelectedItems(items: viewModel.purpose)
        jobVC.setSelectedItems(items: [viewModel.job])
        if viewModel.job == 5 {
            jobVC.input.setAble(text: viewModel.jobInfo!)
        }

        if let gender = viewModel.gender {
            if gender == "male" {
                genderVC.alreadySelected = 0
            } else if gender == "female" {
                genderVC.alreadySelected = 1
            }
        }

        if let year = viewModel.year {
            yearButton.setTitle(text: year, isSmall: false)
            monthButton.setTitle(text: viewModel.month, isSmall: false)
            dayButton.setTitle(text: viewModel.day, isSmall: false)
            yearButton.setDisabled()
            monthButton.setDisabled()
            dayButton.setDisabled()
        } else {
            yearButton.setTitle(text: "년", isSmall: false)
            monthButton.setTitle(text: "월", isSmall: false)
            dayButton.setTitle(text: "일", isSmall: false)
        }

        if let mbti = viewModel.mbti {
            mbtiButton.setTitle(text: mbti, isSmall: false)
        } else {
            mbtiButton.setTitle(text: "mbti선택", isSmall: false)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.setTitle(title: "내 정보 수정하기")
        headerView.delegate = self
        mbtiButton.delegate = self
        yearButton.delegate = self
        monthButton.delegate = self
        dayButton.delegate = self
        nickNameVC.delegate = self

        mbtiButton.setLayout()
        yearButton.setMediumLayout()
        monthButton.setMediumLayout()
        dayButton.setMediumLayout()

        headerView.addSubview(completedButton)
        completedButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -25).isActive = true
        completedButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20).isActive = true
        completedButton.heightAnchor.constraint(equalToConstant: 32).isActive = true

        completedButton.addTarget(self, action: #selector(clickCompleted(_ :)), for: .touchDown)
    }

    func isAllSelected() {
        if viewModel.nickname == "" || viewModel.purpose == [] {
            completedButton.isEnabled = false
        } else if viewModel.job == 5 && viewModel.jobInfo == "" {
            completedButton.isEnabled = false
        } else {
            completedButton.isEnabled = true
        }
    }

    @objc func clickCompleted(_ sender: UIButton) {
        guard let nickname = nickNameVC.getText() else {
            self.showToast(message: "닉네임을 입력하여주세요.")
            return
        }
        if viewModel.job == 5 && viewModel.jobInfo == nil {
            self.showToast(message: "기타 사항을 입력하여 주세요.")
            return
        }
        if viewModel.year != nil && (viewModel.month == "" || viewModel.day == "") {
            self.showToast(message: "생일을 전체 선택하여 주세요.")
            return
        }
        updateUserInfo()
    }
}
