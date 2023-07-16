//
//  AnswerListViewController.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import UIKit

class AnswerListViewController: UIViewController {
    let viewModel = AnswerListViewModel()
    let noneView = NoneAnswerListView()
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var yearButton: DropDownButton!
    @IBOutlet weak var monthButton: DropDownButton!
    @IBOutlet weak var yearHeight: NSLayoutConstraint!
    @IBOutlet weak var monthHeight: NSLayoutConstraint!
    @IBOutlet weak var monthTableView: UITableView!
    @IBOutlet weak var yearTableView: UITableView!
    @IBOutlet weak var containerView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        getAnswerList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delegate = self
        yearButton.setSmallLayout()
        monthButton.setSmallLayout()
        yearButton.setTitle(text: "\(viewModel.year)년", isSmall: true)
        monthButton.setTitle(text: "\(viewModel.month)월", isSmall: true)
        setContainerView(tag: 0)
        setAction()
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let selectedViewController = self.tabBarController?.selectedViewController,
           selectedViewController != self.navigationController {
            self.tabBarController?.tabBar.isHidden = true
        }
    }

    func setContainerView(tag: Int) {
        removeContainerView()
        if tag == 0 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "cardListCollectionViewController") as? CardListCollectionViewController else {
                return
            }
            vc.answerList = self.viewModel.answerList
            addChildAndAddSubview(vc)
        } else {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "listTableViewController") as? ListTableViewController else {
                return
            }
            vc.answerList = self.viewModel.answerList
            addChildAndAddSubview(vc)
        }
    }

    func addChildAndAddSubview(_ childViewController: UIViewController) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        childViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        childViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        childViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        childViewController.didMove(toParent: self)
    }

    func removeContainerView() {
        containerView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        children.forEach { childViewController in
            childViewController.willMove(toParent: nil)
            childViewController.removeFromParent()
        }
    }

    func setNotfoundAnswerList() {
        noneView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(noneView)

        noneView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 95).isActive = true
        noneView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -95).isActive = true
        noneView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        noneView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    @IBAction func changeView(_ sender: UIButton) {
        setContainerView(tag: sender.tag)
    }

    @objc func pushAnswer() {
        let storyboard = UIStoryboard(name: "Answer", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "answer") as? AnswerViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func setAction() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))

        yearButton.addGestureRecognizer(tapGestureRecognizer)
        monthButton.addGestureRecognizer(tapGestureRecognizer2)
    }

    @objc
    func didTapView(_ sender: UITapGestureRecognizer) {
        if sender.view == yearButton {
            if yearTableView.isHidden {
                yearButton.setOpen()
                self.yearTableView.isHidden = false
                UIView.transition(with: self.yearTableView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    if self.viewModel.yearArray.count <= 3 {
                        self.yearHeight.constant = CGFloat(self.viewModel.yearArray.count * 40)
                    } else {
                        self.yearHeight.constant = 160
                    }
                })
            } else {
                yearButton.setClose()
                self.yearHeight.constant = 0
                self.yearTableView.isHidden = true
            }
        } else if sender.view == monthButton {
            if monthTableView.isHidden {
                monthButton.setOpen()
                self.monthTableView.isHidden = false
                UIView.transition(with: self.monthTableView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                        self.monthHeight.constant = 160
                })
            } else {
                monthButton.setClose()
                self.yearHeight.constant = 0
                self.yearTableView.isHidden = true
            }
            self.view.bringSubviewToFront(monthTableView)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: view)

        // 현재 터치가 테이블 뷰 내부에 있는지 확인합니다.
        if yearTableView.frame.contains(touchLocation) {
            monthButton.setClose()
            monthTableView.isHidden = true
            monthHeight.constant = 0
            return
        } else if monthTableView.frame.contains(touchLocation) {
            yearButton.setClose()
            yearTableView.isHidden = true
            yearHeight.constant = 0
        } else {
            monthTableView.isHidden = true
            monthHeight.constant = 0

            yearTableView.isHidden = true
            yearHeight.constant = 0

            monthButton.setClose()
            yearButton.setClose()
        }
    }
}

extension AnswerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == yearTableView {
            return viewModel.yearArray.count
        } else {
            return viewModel.monthArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.id) as? DropDownTableViewCell else {
            return UITableViewCell()
        }
        if tableView == yearTableView {
            cell.setCell(text: String(viewModel.yearArray[indexPath.row]))
        } else {
            cell.setCell(text: String(viewModel.monthArray[indexPath.row]))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DropDownTableViewCell else { return }
        tableView.isHidden = true
        if tableView == yearTableView {
            viewModel.year = cell.getCell()
            yearButton.setTitle(text: "\(cell.getCell())년", isSmall: true)
            yearButton.setClose()
        } else {
            viewModel.month = cell.getCell()
            monthButton.setTitle(text: "\(cell.getCell())월", isSmall: true)
            monthButton.setClose()
        }
        getAnswerList()
    }
}

extension AnswerListViewController: HeaderViewDelegate {
    func pushSetting(_ headerView: HeaderView) {
        // push를 수행하는 코드
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "setting") as? SettingViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
