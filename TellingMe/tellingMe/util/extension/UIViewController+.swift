//
//  UIViewController+.swift
//  tellingMe
//
//  Created by 마경미 on 14.04.23.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String) {
        print("안뇽?")
        let toastLabel = CaptionLabelRegular(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.text = message
        toastLabel.backgroundColor = UIColor(named: "Side200")
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 10
        toastLabel.alpha = 1.0
        toastLabel.sizeToFit()
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(_) in
            toastLabel.removeFromSuperview()
        })
    }
}
