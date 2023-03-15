//
//  ViewController.swift
//  tellingMe
//
//  Created by 마경미 on 08.03.23.
//

import UIKit
import AuthenticationServices

@IBDesignable
class ViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelAnimate()
    }
    
    func labelAnimate() {
        let now = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: now + 1) {
            self.pushAnimate(label: self.label1)
        }
        DispatchQueue.main.asyncAfter(deadline: now + 2) {
            self.pushAnimate(label: self.label2)
        }
        DispatchQueue.main.asyncAfter(deadline: now + 3) {
            self.label3.font = UIFont(name: "NanumSquareRoundOTFB", size: 26)
            self.pushAnimate(label: self.label3)
        }
    }

    private func pushAnimate(label: UILabel) {
        label.isHidden = false
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = .init(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromTop
        label.layer.add(transition, forKey: CATransitionType.push.rawValue)
    }
}
