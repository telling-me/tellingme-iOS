//
//  PremiumViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 16.10.23.
//

import Foundation
import StoreKit

import RxCocoa
import RxSwift

class PremiumViewModel {
//    private let inAppProducts = InAppProducts()
    let plusMemberships: [Premium] = [.oneMonth, .year]
    
    let productSubject = BehaviorSubject<[SKProduct]>(value: [])
    let errorToastSubject = PublishSubject<String>()
    
    init() {
        productSubject.onNext(SubscriptionManager.shared.products)
    }
    
    func purchasePlus(product: SKProduct) {
        SubscriptionManager.shared.purchaseProduct(product: product)
    }
    
    func restorePlus() {
        SubscriptionManager.shared.restorePurchase()
    }
}
