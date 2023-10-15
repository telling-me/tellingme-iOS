//
//  SubscriptionManager.swift
//  tellingMe
//
//  Created by 마경미 on 09.10.23.
//

import Foundation
import StoreKit

public struct InAppProducts {
    static let productIdentifier = Bundle.main.subscriptionId
    let productRequest = SKProductsRequest(productIdentifiers: Set([InAppProducts.productIdentifier]))
    let subscriptionManager = SubscriptionManager(productId: InAppProducts.productIdentifier)
}

class SubscriptionManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    var product: SKProduct?

    init(productId: String) {
        super.init()
        let productRequest = SKProductsRequest(productIdentifiers: Set([productId]))
        productRequest.delegate = self

        productRequest.start()
    }
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        if let product = response.products.first {
            self.product = product
        } else {
            // 상품을 찾지 못한 경우 처리
        }
    }

    public func request(_ request: SKRequest, didFailWithError error: Error) {
        // 요청 실패 처리
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                // 구매 성공
                // 여기에서 구매가 성공했을 때 실행할 코드를 작성합니다.
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                // 구매 실패
                // 여기에서 구매가 실패했을 때 실행할 코드를 작성합니다.
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                // 복원 (restore) 처리
                // 여기에서 구매 복원이 필요한 경우 실행할 코드를 작성합니다.
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
}
