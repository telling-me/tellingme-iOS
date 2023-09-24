//
//  BaseViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.09.23.
//

import UIKit

class BaseViewController: UIViewController {
    private var alertView: CustomAlertView?
    // bottomsheet 등 정의해두는게 어떨까?

    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseViewController()
    }
}

extension BaseViewController {
    private func setBaseViewController() {
        view.backgroundColor = .Side100
    }
}

extension BaseViewController {
    private func showAlertView() {
        alertView = CustomAlertView()
    
        guard let alertView else {
            return
        }

        view.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.showAlert()
    }
    
    private func dissmissAlertView() {
        alertView?.removeFromSuperview()
        
        alertView?.dismissAlert()
    }
}


