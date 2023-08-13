//
//  SignUpViewController.swift
//  tellingMe
//
//  Created by 마경미 on 26.03.23.
//

import UIKit
import GradientProgress

class SignUpViewController: UIViewController {
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var progressBar: GradientProgressBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        setInitUI()
    }

    func setInitUI() {
        progressBar.setProgress(Float(0)/Float(5), animated: true)
        progressBar.gradientColors = [  UIColor(red: 0.486, green: 0.937, blue: 0.655, alpha: 1).cgColor,
                                        UIColor(red: 0.561, green: 0.827, blue: 0.957, alpha: 1).cgColor]
    }

    @IBAction func clickSkipButton(_ sender: UIButton) {
        guard let pageViewController = children.first as? SignUpPageViewController else {
            return
        }
        pageViewController.nextPage()
    }
}

extension SignUpViewController {
    public func setProgress(with value: Float) {
        progressBar.setProgress(value, animated: true)
    }

    public func setSkipButtonHidden() {
        skipButton.isHidden = true
    }

    public func setSkipButtonUnhidden() {
        skipButton.isHidden = false
    }
}
