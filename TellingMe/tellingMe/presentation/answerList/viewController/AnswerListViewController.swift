//
//  AnswerListViewController.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import UIKit
import RxSwift
import RxCocoa

class AnswerListViewController: DropDownViewController {
    let viewModel = AnswerListViewModel()
    let noneView = NoneAnswerListView()
    @IBOutlet weak var headerView: MainHeaderView!
    @IBOutlet weak var yearButton: DropDownButton!
    @IBOutlet weak var monthButton: DropDownButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var listButton: [UIButton]!

    let disposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        viewModel.getAnswerList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        yearButton.delegate = self
        monthButton.delegate = self

//        listButton[0].backgroundColor = UIColor(named: "Side200")
        setSmallDropDownLayout()
        yearButton.setSmallLayout()
        monthButton.setSmallLayout()
        yearButton.setTitle(text: "\(viewModel.year)년", isSmall: true)
        monthButton.setTitle(text: "\(viewModel.month)월", isSmall: true)
        self.view.bringSubviewToFront(tableView)
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.responseSubject
            .subscribe(onNext: { [weak self] response in
                if response.count == 0 {
                    self?.containerView.isHidden = true
                    self?.setNotfoundAnswerList()
                } else {
                    self?.noneView.removeFromSuperview()
                    self?.containerView.isHidden = false
                    self?.setContainerView(tag: self?.viewModel.currentlistTag ?? 0)
                }
            }).disposed(by: disposeBag)
    }

    func setContainerView(tag: Int) {
        removeContainerView()
        if tag == 0 {
            makeSelectedCardButton(selectedIndex: 0, unSelectedIndex: 1)
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "cardListCollectionViewController") as? CardListCollectionViewController else {
                return
            }
            vc.answerList = self.viewModel.answerList
            addChildAndAddSubview(vc)
            vc.collectionView.reloadData()
        } else {
            makeSelectedCardButton(selectedIndex: 1, unSelectedIndex: 0)
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "listTableViewController") as? ListTableViewController else {
                return
            }
            vc.answerList = self.viewModel.answerList
            addChildAndAddSubview(vc)
        }
    }

    func makeSelectedCardButton(selectedIndex: Int, unSelectedIndex: Int) {
        listButton[selectedIndex].backgroundColor = UIColor(named: "Side200")
        listButton[unSelectedIndex].backgroundColor = UIColor(named: "Side100")
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
        viewModel.currentlistTag = sender.tag
        setContainerView(tag: sender.tag)
    }

    @objc func pushAnswer() {
        let storyboard = UIStoryboard(name: "Answer", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "answer") as? AnswerViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AnswerListViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.currentTag {
        case 0:
            viewModel.year = viewModel.yearArray[indexPath.row]
            yearButton.setClose()
            yearButton.setTitle(text: "\(viewModel.year)년", isSmall: true)
        case 1:
            viewModel.month = viewModel.monthArray[indexPath.row]
            monthButton.setClose()
            monthButton.setTitle(text: "\(viewModel.month)월", isSmall: true)
        default:
            fatalError("currentTag 설정 해주세요")
        }
        viewModel.getAnswerList()
        tableView.isHidden = true
        tableView.removeFromSuperview()
    }
}

extension AnswerListViewController: DropDownButtonDelegate {
    func showDropDown(_ button: DropDownButton) {
        viewModel.currentTag = button.tag
        switch button.tag {
        case 0:
            items = viewModel.yearArray
        case 1:
            items = viewModel.monthArray
        default:
            break
        }

        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        if tableView.isHidden {
            button.setOpen()
            view.addSubview(tableView)
            tableView.isHidden = false

            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
                tableView.heightAnchor.constraint(equalToConstant: 208)
            ])
        } else {
            button.setClose()
            tableView.isHidden = true
            tableView.removeFromSuperview()
        }
        tableView.reloadData()
    }
}
