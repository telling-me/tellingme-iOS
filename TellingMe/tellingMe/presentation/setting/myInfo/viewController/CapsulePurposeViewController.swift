//
//  PurposeViewController.swift
//  tellingMe
//
//  Created by 마경미 on 15.05.23.
//

import UIKit

class CapsulePurposeViewController: CapsuleCollectionViewController {
    let viewModel = CapsulePurposeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setItems(items: viewModel.purposeList)
    }
}
