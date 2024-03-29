//
//  BaseViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.09.23.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    private var alertView: CustomAlertView?
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
        setBaseViewController()
    }
    
    func bindViewModel() {}
    func setStyles() { }
    func setLayout() { }
}

extension BaseViewController {
    private func setBaseViewController() {
        view.backgroundColor = .Side100
    }
}

extension BaseViewController {
    func showAlertView(message: String) {
        alertView = CustomAlertView(frame: .zero, message: message)

        guard let alertView else {
            return
        }

        view.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.showAlert()
        alertView.buttonTapObserver
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.dismissAlertView()
            })
            .disposed(by: disposeBag)
        
    }
    
    func dismissAlertView() {
        alertView?.dismissAlert()
        
        alertView?.removeFromSuperview()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


