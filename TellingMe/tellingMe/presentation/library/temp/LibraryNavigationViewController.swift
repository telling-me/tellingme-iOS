//
//  LibraryNavigationViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.08.23.
//

import UIKit

class LibraryNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = LibraryViewController()
        setViewControllers([viewController], animated: false)
    }
}
