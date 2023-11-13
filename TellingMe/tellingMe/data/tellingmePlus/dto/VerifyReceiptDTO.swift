//
//  VerifyReceiptDTO.swift
//  tellingMe
//
//  Created by 마경미 on 14.11.23.
//

import Foundation

struct VerifyReceiptRequest: Codable {
    let receiptData: String
}

struct ReceiptInfo: Codable {
    let cancellationDate: String
    let cancellationDateMs: String
    let cancellationDatePst: String
    let cancellationReason: String
    let expiresDate: String
    let expiresDateMs: String
    let expiresDatePst: String
    let isInIntroOfferPeriod: String
    let isTrialPeriod: String
    let isUpgraded: String
    let offerCodeRefName: String
    let originalPurchaseDate: String
    let originalPurchaseDateMs: String
    let originalPurchaseDatePst: String
    let originalTransactionId: String
    let productId: String
    let promotionalOfferId: String
    let purchaseDate: String
    let purchaseDateMs: String
    let purchaseDatePst: String
    let quantity: String
    let subscriptionGroupIdentifier: String
    let transactionId: String
    let webOrderLineItemId: String
}

struct VerifyReceiptResponse: Codable {
    let environment: String
    let latestReceipt: String
    let receiptInfoList: [ReceiptInfo]
    let status: Int
    let retryable: Bool
}
