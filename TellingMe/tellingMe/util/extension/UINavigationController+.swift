////
////  UINavigationController+.swift
////  tellingMe
////
////  Created by KYUBO A. SHIM on 2023/10/23.
////
//
//import UIKit
//
//extension UINavigationController: UIGestureRecognizerDelegate {
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = self
//    }
//    
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count > 1
//    }
//}
