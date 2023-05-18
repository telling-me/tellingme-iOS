//
//  GetBirthViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class GetBirthdayViewController: UIViewController {
    @IBOutlet weak var yearTableView: UITableView!
    @IBOutlet weak var monthTableView: UITableView!
    @IBOutlet weak var dayTableView: UITableView!

    @IBOutlet weak var yearHeight: NSLayoutConstraint!
    @IBOutlet weak var monthHeight: NSLayoutConstraint!
    @IBOutlet weak var dayHeight: NSLayoutConstraint!

    @IBOutlet weak var yearButton: DropDownButton!
    @IBOutlet weak var monthButton: DropDownButton!
    @IBOutlet weak var dayButton: DropDownButton!

    @IBOutlet weak var nextButton: SecondayIconButton!
    @IBOutlet weak var prevButton: SecondayIconButton!
    let viewModel = GetBirthdayViewModel()
    let today = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        yearButton.setMediumLayout()
        monthButton.setMediumLayout()
        dayButton.setMediumLayout()
        yearButton.setTitle(text: "년", isSmall: false)
        monthButton.setTitle(text: "월", isSmall: false)
        dayButton.setTitle(text: "일", isSmall: false)
        prevButton.setImage(image: "ArrowLeft")
        nextButton.isEnabled = false
        nextButton.setImage(image: "ArrowRight")
        setAction()
    }

    func setAction() {
        let tapGestureRecognizer_year = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        let tapGestureRecognizer_month = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        let tapGestureRecognizer_day = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))

        yearButton.addGestureRecognizer(tapGestureRecognizer_year)
        monthButton.addGestureRecognizer(tapGestureRecognizer_month)
        dayButton.addGestureRecognizer(tapGestureRecognizer_day)
    }

    func setEnabled() {
        if viewModel.year != nil {
            monthButton.isUserInteractionEnabled = true
            if viewModel.month != nil {
                dayButton.isUserInteractionEnabled = true
            } else {
                dayButton.isUserInteractionEnabled = false
            }
        } else {
            monthButton.isUserInteractionEnabled = false
            dayButton.isUserInteractionEnabled = false
        }
    }

    @objc
    func didTapView(_ sender: UITapGestureRecognizer) {
        if sender.view == yearButton {
            if yearTableView.isHidden {
                self.yearTableView.isHidden = false
                UIView.transition(with: self.yearTableView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.yearHeight.constant = 208
                })
            } else {
                self.yearHeight.constant = 0
                self.yearTableView.isHidden = true
            }
        } else if sender.view == monthButton {
            if monthTableView.isHidden {
                self.monthTableView.isHidden = false
                UIView.transition(with: self.monthTableView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.monthHeight.constant = 208
                })
            } else {
                self.yearHeight.constant = 0
                self.yearTableView.isHidden = true
            }
        } else {
            if dayTableView.isHidden {
                self.dayTableView.isHidden = false
                UIView.transition(with: self.dayTableView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.dayHeight.constant = 208
                })
            } else {
                self.yearHeight.constant = 0
                self.dayTableView.isHidden = true
            }
        }
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.nextPage()

        SignUpData.shared.makeBirthData(year: viewModel.year, month: viewModel.month, day: viewModel.day)
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPage()
    }
}

extension GetBirthdayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == yearTableView {
            return 100
        } else if tableView == monthTableView {
            return 12
        } else {
            if viewModel.month == "2" {
                return 28
            } else if viewModel.month == "1" || viewModel.month == "3" || viewModel.month == "5" || viewModel.month == "7" || viewModel.month == "8" || viewModel.month == "10" || viewModel.month == "12" {
                return 31
            } else {
                return 30
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.id) as? DropDownTableViewCell else { return UITableViewCell() }
        if tableView == yearTableView {
            if let selectedYear = viewModel.yearArray {
                cell.setCell(text: String(selectedYear[indexPath.row]))
            }
        } else if tableView == monthTableView {
            cell.setCell(text: String(viewModel.monthArray[indexPath.row]))
        } else {
            cell.setCell(text: String(viewModel.day_Array[indexPath.row]))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DropDownTableViewCell else { return }
        tableView.isHidden = true
        if tableView == yearTableView {
            yearButton.setTitle(text: cell.getCell(), isSmall: false)
            viewModel.year = cell.getCell()
        } else if tableView == monthTableView {
            monthButton.setTitle(text: cell.getCell(), isSmall: false)
            viewModel.month = cell.getCell()
        } else {
            dayButton.setTitle(text: cell.getCell(), isSmall: false)
            viewModel.day = cell.getCell()
            nextButton.isEnabled = true
        }
        setEnabled()
    }
}
