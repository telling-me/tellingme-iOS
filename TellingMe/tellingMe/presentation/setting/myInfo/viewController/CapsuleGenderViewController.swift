//
//  CapsuleBirthdayViewController.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import UIKit

class CapsuleGenderViewController: CapsuleCollectionViewController {
    let viewModel = CapsuleGenderViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setItems(items: viewModel.genders)
    }
}
