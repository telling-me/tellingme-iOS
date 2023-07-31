//
//  CommunicationDetailViewController.swift
//  tellingMe
//
//  Created by 마경미 on 28.07.23.
//

import UIKit
import SwiftUI

class CommunicationDetailViewController: UIViewController {
//    let viewModel = CommunicationDetailViewModel()

    @IBOutlet weak var backHeaderview: BackHeaderView!
    override func viewDidLoad() {
        backHeaderview.delegate = self
    }

}
