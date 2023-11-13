//
//  SubscriptionManager.swift
//  tellingMe
//
//  Created by 마경미 on 09.10.23.
//

import Foundation
import StoreKit

import RxSwift
//
//// 앱 초반에 request 시키기
//class InAppProducts {
//    static let shared = InAppProducts() // 공유 인스턴스 추가
//    
//    private let productIds: [String]
//    private let productRequest: SKProductsRequest
//    let subscriptionManager: SubscriptionManager
//    
//    
//    private init() {
//        self.productIds = Bundle.main.subscriptionIds
//        self.productRequest = SKProductsRequest(productIdentifiers: Set(self.productIds))
//        self.subscriptionManager = SubscriptionManager()
//        SKPaymentQueue.default().add(subscriptionManager)
//        
//        self.productRequest.delegate = self.subscriptionManager
//        self.productRequest.start()
//    }
//}

final class SubscriptionManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    private let productIds: [String]
    private let productRequest: SKProductsRequest

    var products: [SKProduct] = []
    let purchasedSubject = PublishSubject<Void>()
    let purchasingSubject = PublishSubject<Void>()
    let canceldSubject = PublishSubject<Void>()
    let failedSubject = PublishSubject<Void>()
    let deferredSubject = PublishSubject<Void>()
    let restoredSubject = PublishSubject<Void>()
    let errorSubject = PublishSubject<String>()
    let successedVerifyReceiptSubject = PublishSubject<String>()
    
    var isAuthorizedForPayments: Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    static let shared = SubscriptionManager()
    
    private override init() {
        self.productIds = Bundle.main.subscriptionIds
        self.productRequest = SKProductsRequest(productIdentifiers: Set(self.productIds))
        super.init()
        
        self.productRequest.delegate = self
        self.productRequest.start()
    }
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        // 상품이 없는 경우 종료
        if response.products.isEmpty {
            return
        }

        self.products = response.products
    }

    public func request(_ request: SKRequest, didFailWithError error: Error) {
        // 요청 실패 처리
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                purchasingSubject.onNext(())
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                purchasedSubject.onNext(())
                fetchReceipt()
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                failedSubject.onNext(())
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                restoredSubject.onNext(())
            case .deferred:
                deferredSubject.onNext(())
            default:
                break
            }
        }
    }
    
    func addPaymentQueue() {
        SKPaymentQueue.default().add(self)
    }
    
    func removePaymentQueue() {
        SKPaymentQueue.default().remove(self)
    }
    
    func fetchReceipt() {
        if let receiptURL = Bundle.main.appStoreReceiptURL {
            do {
                let receiptData = try Data(contentsOf: receiptURL)
                let receiptString = receiptData.base64EncodedString(options: [])

                self.successedVerifyReceiptSubject.onNext(receiptString)
            } catch {
                print("영수증 데이터를 읽는 데 실패했습니다: \(error.localizedDescription)")
            }
        } else {
            print("앱 스토어 영수증을 찾을 수 없습니다.")
        }
    }
    
    func purchaseProduct(product: SKProduct) {
        if isAuthorizedForPayments {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            errorSubject.onNext("결제를 진행할 수 없습니다.")
        }
    }
    
    func restorePurchase() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}
