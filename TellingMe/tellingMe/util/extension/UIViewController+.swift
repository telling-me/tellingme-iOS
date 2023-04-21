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
        let view = ErrorToast()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)

        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -107).isActive = true
        view.heightAnchor.constraint(equalToConstant: 44).isActive = true

        view.setLayout()
        view.setMessage(message: message)

        view.alpha = 1.0

        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
             view.alpha = 0.0
        }, completion: {(_) in
            view.removeFromSuperview()
        })
    }
}
