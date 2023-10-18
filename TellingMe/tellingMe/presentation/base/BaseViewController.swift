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
    let indicatorView = UIActivityIndicatorView(style: .large)
    // bottomsheet 등 정의해두는게 어떨까?
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseViewController()
    }
}

extension BaseViewController {
    private func setBaseViewController() {
        view.backgroundColor = .Side100
        
        indicatorView.do {
            $0.color = .gray // 인디케이터 색상 설정
//            activityIndicator.center = view.center // 화면 중앙에 위치
            $0.hidesWhenStopped = true
        }
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
    
    func loadingStarts() {
        indicatorView.startAnimating()
    }
    
    func loadingStops() {
        indicatorView.stopAnimating()
    }
}


