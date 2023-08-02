//
//  CommunicationDetailViewController.swift
//  tellingMe
//
//  Created by 마경미 on 28.07.23.
//

import UIKit

class CommunicationDetailViewController: UIViewController {
    //    let viewModel = CommunicationDetailViewModel()
    
    var pageViewController: CommunicationPageViewController?
    @IBOutlet weak var prevButton: UIView!
    @IBOutlet weak var nextButton: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backHeaderview: BackHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backHeaderview.delegate = self
        let prevTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPageControlButton))
        let nextTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPageControlButton))
        
        prevButton.tag = 0
        nextButton.tag = 1
        
        prevButton.addGestureRecognizer(prevTapGestureRecognizer)
        nextButton.addGestureRecognizer(nextTapGestureRecognizer)
        
        for childViewController in children {
            if let childPageViewController = childViewController as? CommunicationPageViewController {
                pageViewController = childPageViewController
                break
            }
        }
    }
    
    @objc func clickPageControlButton(_ sender: UITapGestureRecognizer) {
        // prev
        if sender.view?.tag == 0 {
            pageViewController?.prevPage()
        } else {
            // next
            pageViewController?.nextPage()
        }
    }
    
}
