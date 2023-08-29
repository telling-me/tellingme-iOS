//
//  MyPageViewModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/29.
//

import UIKit

import RxCocoa
import RxMoya
import RxSwift

protocol MyPageInputs {
    func premiumInAppPurchaseTapped()
    func tellingMeBootPayPurchaseTapped()
    func faqTapped()
    func myProfileTapped()
    func togglePushAlarmPermission(isAllowed: Bool)
    func lockSettingTapped()
    func termsOfUseTapped()
    func privatePolicyTapped()
    func withdrawalTapped()
    func logoutTapped()
}

protocol MyPageOutputs {
    
}

protocol MyPageViewModelType {
    
}

final class MyPageViewModel {
    
}
