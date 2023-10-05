//
//  UIViewController+.swift
//  tellingMe
//
//  Created by 마경미 on 14.04.23.
//

import Foundation
import RxSwift
import UIKit

extension UIViewController: BackHeaderViewDelegate {
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func dismissViewController() {
        self.dismiss(animated: true)
    }
}

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

        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseIn, animations: {
             view.alpha = 0.0
        }, completion: {(_) in
            view.removeFromSuperview()
        })
    }
    
    func showGreenToast(message: String) {
        let view = InfoToast()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)

        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        view.heightAnchor.constraint(equalToConstant: 44).isActive = true

        view.setLayout()
        view.setMessage(message: message)

        view.alpha = 1.0

        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
             view.alpha = 0.0
        }, completion: {(_) in
            view.removeFromSuperview()
        })
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
