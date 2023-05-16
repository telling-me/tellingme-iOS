//
//  JobViewController.swift
//  tellingMe
//
//  Created by 마경미 on 15.05.23.
//

import UIKit

class CapsuleJobViewController: CapsuleCollectionViewController {
    let viewModel = CapsuleJobViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setItems(items: viewModel.jobs)
    }
}
