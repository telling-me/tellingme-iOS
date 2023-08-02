//
//  CommunicationDetailViewController.swift
//  tellingMe
//
//  Created by 마경미 on 28.07.23.
//

import UIKit

class CommunicationDetailViewController: UIViewController {
//    let viewModel = CommunicationDetailViewModel()

    
    @IBOutlet weak var prevButton: UIView!
    @IBOutlet weak var nextButton: UIView!
    @IBOutlet weak var backHeaderview: BackHeaderView!

    override func viewDidLoad() {
        let prevGestureRecognizer: UIGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(clickPageControlButton))
        let nextGestureRecognizer: UIGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(clickPageControlButton))
        backHeaderview.delegate = self
        prevButton.addGestureRecognizer(prevGestureRecognizer)
        nextButton.addGestureRecognizer(nextGestureRecognizer)
    }
    
    @objc func clickPageControlButton(_ sender: UITapGestureRecognizer) {
        // prev
        if sender.view?.tag == 0 {
            let pageViewController = CommunicationPageViewController()
            pageViewController.prevPage()
        } else {
            let pageViewController = CommunicationPageViewController()
            pageViewController.nextPage()
        }
    }

}
