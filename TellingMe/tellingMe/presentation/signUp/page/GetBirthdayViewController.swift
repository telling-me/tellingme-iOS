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

    let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary400main")
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let pageViewController = self.parent as? SignUpPageViewController
        pageViewController?.prevPageWithIndex(index: 2)
    }
}

extension GetBirthdayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == yearTableView {
            
        } else if tableView == monthTableView {
            return 12
        } else {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == yearTableView {
            
        } else if tableView == monthTableView {
            
        } else {
             return 
        }
    }
    
    
}
