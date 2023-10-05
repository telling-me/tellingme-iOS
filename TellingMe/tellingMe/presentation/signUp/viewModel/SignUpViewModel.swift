//
//  SignUpViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 27.09.23.
//

import Foundation
import UIKit

class SignUpViewModel {
    var currentIndex: Int = 0
    
    lazy var viewControllers: [UIViewController] = {
        return [AgreementViewController(viewModel: self), NickNameViewController()]
    }()
}
