//
//  BirthdayViewController.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit

class BirthdayViewController: DropDownViewController {
    let viewModel = BirthdayViewModel()
    
    let stackview: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let yearArray = viewModel.yearArray {
            let stringArray = yearArray.map { String($0) }
            items = stringArray
        } else {
            fatalError("year 정보를 불러오지 못 했습니다.")
        }
        
        view.addSubview(stackview)
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }

    func addButtons() {
        for (index, text) in viewModel.textArrays.enumerated() {
            let button: DropDownButton = {
                let view = DropDownButton()
                view.setMediumLayout()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.setTitle(text: text, isSmall: false)
                view.tag = index
                return view
            }()
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
            button.addGestureRecognizer(tapGestureRecognizer)
            self.stackview.addArrangedSubview(button)
        }
    }

    @objc
    func didTapView(_ sender: UITapGestureRecognizer) {
        switch sender.view!.tag {
        case 0:
            tableView.isHidden = false
            updateTableViewLayout(leading:  trailing: sender.view!.trailingAnchor, top: sender.view!.topAnchor, height: 208)
        case 1:
            tableView.isHidden = false
            updateTableViewLayout(leading: <#T##CGFloat#>, trailing: <#T##CGFloat#>, top: <#T##CGFloat#>, height: <#T##CGFloat#>)
        case 2:
            tableView.isHidden = false
            updateTableViewLayout(leading: <#T##CGFloat#>, trailing: <#T##CGFloat#>, top: <#T##CGFloat#>, height: <#T##CGFloat#>)
        default:
            break
        }
    }
}
