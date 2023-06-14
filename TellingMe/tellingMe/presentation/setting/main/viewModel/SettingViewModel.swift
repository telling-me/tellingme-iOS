//
//  SettingViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 17.05.23.
//

import Foundation
import UIKit

class SettingViewModel {
    struct SettingView {
        let id: String
        let view: UIViewController
    }

    let items = [SettingView(id: "myInfo", view: MyInfoViewController()), SettingView(id: "termOfUse", view: TermOfUseViewController()), SettingView(id: "privacyPolicy", view: PrivacyPolicyViewController()), SettingView(id: "withdrawal", view: WithdrawalViewController())]
    var itemsCount: Int?

    init() {
        itemsCount = items.count
    }
}
