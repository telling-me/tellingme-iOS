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
        button.setTitleColor(UIColor(named: "Gray2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
            genderVC.collectionView.isUserInteractionEnabled = false
            if gender == "남성" {
                genderVC.setSelectedItems(items: [0])
            } else if gender == "여성" {
                genderVC.setSelectedItems(items: [1])
            }
        }

        if let year = viewModel.year {
            yearButton.setTitle(text: year, isSmall: false)
            yearButton.isUserInteractionEnabled = false
            monthButton.setTitle(text: viewModel.month, isSmall: false)
            monthButton.isUserInteractionEnabled = false
            dayButton.setTitle(text: viewModel.day, isSmall: false)
            dayButton.isUserInteractionEnabled = false
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

    @objc func clickCompleted(_ sender: UIButton) {
        updateUserInfo()
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
            monthButton.setTitle(text: viewModel.month, isSmall: false)
        case 2:
            viewModel.day = viewModel.dayArray[indexPath.row]
            dayButton.setTitle(text: viewModel.day, isSmall: false)
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
